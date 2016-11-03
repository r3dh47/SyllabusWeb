package com.junior.dao.component;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.junior.conexion.AccesoDB;
import com.junior.dao.design.IAsignaturaAperturadaDao;

public class AsignaturaAperturadaDao implements IAsignaturaAperturadaDao{

    protected AccesoDB db;

    public AsignaturaAperturadaDao()
    {
        db = new AccesoDB();
    }

    @Override
    public String obtenerNombreDeAsignaturaPorId(Integer id)
    {
        String nombre = null;
        String procedimiento_almacenado = "{}";
        Connection cn = db.getConnection();

        if (cn != null) {
            try {
                CallableStatement cs = cn.prepareCall(procedimiento_almacenado);
                ResultSet rs = cs.executeQuery();

                if (rs.next()) {
                    nombre = rs.getString("nombre");
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

        return nombre;
    }
}