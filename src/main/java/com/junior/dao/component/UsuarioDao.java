package com.junior.dao.component;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.junior.conexion.IAccesoDB;
import com.junior.dao.design.IUsuarioDao;
import com.junior.to.Rol;
import com.junior.to.Usuario;

import oracle.jdbc.internal.OracleTypes;

public class UsuarioDao implements IUsuarioDao {

    @Autowired
    protected IAccesoDB db;

    public void setDb(IAccesoDB db)
    {
        this.db = db;
    }

    @Override
    public Usuario obtenerUsuario(String correo)
    {
        Usuario usuario = new Usuario();
        List<Rol> roles = new ArrayList<Rol>();

        String procedimientoAlmacenado = "{ call PAC_CURSOR.RET_USUARIO_X_EMAIL(?, ?)}";

        Connection cn = this.db.getConnection();

        if (cn != null) {
            try {
                CallableStatement proc = cn.prepareCall(procedimientoAlmacenado);
                proc.registerOutParameter("O_CURSOR", OracleTypes.CURSOR);
                proc.setString("EMAIL", correo);
                proc.execute();

                ResultSet rs = (ResultSet) proc.getObject("O_CURSOR");

                if (rs.next()) {
                    usuario.setCorreo(correo);
                    usuario.setContrasenia(rs.getString("PASSWORD"));
                    usuario.setId(rs.getInt("ID_USUARIO"));

                    String procedimientoAlmacenado2 = "{ call PAC_CURSOR.RET_ROLES_X_USUARIO(?,?)}";
                    CallableStatement proc2 = cn.prepareCall(procedimientoAlmacenado2);
                    proc2.registerOutParameter("o_cursor", OracleTypes.CURSOR);
                    proc2.setInt("p_id_usuario", usuario.getId());
                    proc2.execute();

                    rs = (ResultSet) proc2.getObject("o_cursor");

                    while (rs.next()) {
                        Rol rol = new Rol();

                        rol.setNombre(rs.getString("NOMBRE_ROL"));
                        rol.setId(rs.getInt("ID_ROL"));
                        roles.add(rol);
                    }

                    usuario.setRoles(roles);
                }
            } catch(SQLException ex) {
                System.err.println(ex.getMessage());
            } finally {
                try {
                    cn.close();
                } catch (Exception e) {
                    System.err.println(e.getMessage());
                }
            }
        }

        return usuario;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException
    {
        Usuario usuario = this.obtenerUsuario(username);
        Collection<GrantedAuthority> accesos = new ArrayList<GrantedAuthority>();
        // Convertirlos en una coleccion de GrantedAuthority
        accesos.add(new SimpleGrantedAuthority("ROLE_USER"));
        for (Rol rol : usuario.getRoles()) {
            accesos.add(new SimpleGrantedAuthority(rol.getNombre()));
        }

        return new User(
                usuario.getCorreo(),
                usuario.getContrasenia(),
                true,
                true,
                true,
                true,
                accesos
                );
    }

    @Override
    public Boolean autenticar(String username, String password)
    {
        Boolean resultado = false;

        String procedimientoAlmacenado = "{ ? = call AUTENTICAR(?, ?)}";

        Connection cn = this.db.getConnection();

        if (cn != null) {
            try {
                CallableStatement proc = cn.prepareCall(procedimientoAlmacenado);
                proc.registerOutParameter(1, Types.NUMERIC);
                proc.setString(2, username);
                proc.setString(3, password);
                proc.executeQuery();
                resultado = (proc.getInt(1) > 0);
            } catch(SQLException ex) {
                System.err.println(ex.getMessage());
            } finally {
                try {
                    cn.close();
                } catch (Exception e) {
                    System.err.println(e.getMessage());
                }
            }
        }

        return resultado;
    }


}
