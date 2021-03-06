package com.junior.dao.component;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.junior.conexion.IAccesoDB;
import com.junior.dao.design.ITemaDao;
import com.junior.to.Syllabus;
import com.junior.to.Tema;

import oracle.jdbc.internal.OracleTypes;

public class TemaDao implements ITemaDao {

    @Autowired
    protected IAccesoDB db;

    public void setDb(IAccesoDB db)
    {
        this.db = db;
    }

    @Override

    public List<Tema> obtenerPorSyllabus(Syllabus syllabus)
    {

        List<Tema> temas = new ArrayList<Tema>();

        String procedimientoAlmacenado = "{ call PAC_CURSOR.RET_TEMAS_X_SYLLABUS(?, ?)}";

        Connection cn = this.db.getConnection();

        if (cn != null) {
            try {
                CallableStatement proc = cn.prepareCall(procedimientoAlmacenado);
                proc.registerOutParameter("O_CURSOR", OracleTypes.CURSOR);
                proc.setInt("p_id_syllabus", syllabus.getId());
                proc.execute();

                ResultSet rs = (ResultSet) proc.getObject("O_CURSOR");

                while (rs.next()) {
                    Tema tema = new Tema();
                    tema.setDescripcion(rs.getString("DESCRIPCION"));
                    tema.setUnidad(rs.getInt("UNIDAD"));
                    tema.setSemana(rs.getInt("SEMANA"));
                    tema.setTipoId(rs.getInt("ID_TIPO"));
                    tema.setSyllabusId(syllabus.getId());

                    temas.add(tema);

                }
            } catch (SQLException ex) {
                System.err.println(ex.getMessage());
            } finally {
                try {
                    cn.close();
                } catch (Exception e) {
                    System.err.println(e.getMessage());
                }
            }
        }

        return temas;

    }

    @Override
    public String editarTema(Tema tema, Integer idSyllabus)
    {
        String rpta = null;
        String prc_editarTema = "{CALL EDITAR_TEMA(?,?,?,?,?,?)}";
        Connection cn = db.getConnection();

        if (cn != null) {
            try {
                CallableStatement cs = cn.prepareCall(prc_editarTema);
                cs.setInt(1, tema.getId());
                cs.setString(2, tema.getDescripcion());
                cs.setInt(3, tema.getUnidad());
                cs.setInt(4, tema.getSemana());
                cs.setInt(5, tema.getTipoId());
                cs.setInt(6, idSyllabus);

                int actualizo = cs.executeUpdate();

                if (actualizo == 0) {
                    rpta = "ERROR";
                }
            } catch (SQLException ex) {
                rpta = ex.getMessage();
            } finally {
                try {
                    cn.close();
                } catch (SQLException e) {
                    rpta = e.getMessage();
                }
            }
        }
        return rpta;
    }

    @Override
    public String eliminarTema(Tema tema)
    {

        String rpta = null;
        String prc_eliminarTema = "{CALL ELIMINAR_TEMA(?)}";
        Connection cn = db.getConnection();

        if (cn != null) {
            try {
                CallableStatement cs = cn.prepareCall(prc_eliminarTema);
                cs.setInt(1, tema.getId());

                int actualizo = cs.executeUpdate();

                if (actualizo == 0) {
                    rpta = "ERROR";
                }
            } catch (SQLException ex) {
                rpta = ex.getMessage();
            } finally {
                try {
                    cn.close();
                } catch (SQLException e) {
                    rpta = e.getMessage();
                }
            }
        }
        return rpta;

    }

    @Override
    public List<Tema> obtenerTemasPorGrupo(Integer idGrupo, Integer semanaInicio, Integer semanaFin)
    {
        List<Tema> temas = new ArrayList<Tema>();

        String procedimientoAlmacenado = "{ call PAC_CURSOR.LISTAR_TEMAS_X_GRUPO(?, ?, ?, ?)}";

        Connection cn = this.db.getConnection();

        if (cn != null) {
            try {
                CallableStatement proc = cn.prepareCall(procedimientoAlmacenado);
                proc.registerOutParameter("o_cursor", OracleTypes.CURSOR);
                proc.setInt("grupo_id", idGrupo);
                proc.setInt("p_sem_inicio", semanaInicio);
                proc.setInt("p_sem_fin", semanaFin);
                proc.execute();

                ResultSet rs = (ResultSet) proc.getObject("o_cursor");

                while (rs.next()) {
                    Tema tema = new Tema();
                    tema.setId(rs.getInt("ID_TEMA"));
                    tema.setDescripcion(rs.getString("DESCRIPCION"));
                    tema.setSemana(rs.getInt("SEMANA"));
                    tema.setUnidad(rs.getInt("UNIDAD"));

                    temas.add(tema);
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

        return temas;
    }

    @Override
    public List<Tema> obtenerAvancePorValidar(Integer idGrupo, Integer idAlumno)
    {
        List<Tema> temasAvanzadosPorValidar = new ArrayList<Tema>();

        String procedimientoAlmacenado = "{ call PAC_CURSOR.LISTAR_TEMAS_A_VALIDAR_X_GRUPO(?,?,?)}";

        Connection cn = this.db.getConnection();

        if (cn != null) {
            try {
                CallableStatement proc = cn.prepareCall(procedimientoAlmacenado);
                proc.setInt(1, idGrupo);
                proc.setInt(2, idAlumno);
                proc.registerOutParameter(3, OracleTypes.CURSOR);

                proc.execute();

                ResultSet rs = (ResultSet) proc.getObject(3);

                while (rs.next()) {
                    Tema tema = new Tema();
                    tema.setId(rs.getInt("ID_TEMA"));
                    tema.setUnidad(rs.getInt("UNIDAD"));
                    tema.setSemana(rs.getInt("SEMANA"));
                    tema.setDescripcion(rs.getString("DESCRIPCION"));
                    tema.setTipoId(rs.getInt("ID_TIPO"));
                    tema.setSyllabusId(rs.getInt("ID_SYLLABUS"));

                    temasAvanzadosPorValidar.add(tema);
                }
            } catch (SQLException ex) {
                System.err.println(ex.getMessage());
            } finally {
                try {
                    cn.close();
                } catch (Exception e) {
                    System.err.println(e.getMessage());
                }
            }
        }

        return temasAvanzadosPorValidar;
    }

    @Override
    public Boolean obtenerSiIngresoTemas(Integer idSesion)
    {
        Boolean resultado = false;
        String procedimientoAlmacenado = "{ ? = call RET_INGRESO_TEMAS(?)}";
        Connection cn = this.db.getConnection();

        if (cn != null) {
            try {
                CallableStatement proc = cn.prepareCall(procedimientoAlmacenado);
                proc.registerOutParameter("v_resultado", Types.INTEGER);
                proc.setInt("p_id_sesion", idSesion);
                proc.executeQuery();

                resultado = (proc.getInt("v_resultado") > 0);
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

    @Override
    public String insertarAvanceDeTemas(List<Integer> temasId, Integer sesionId)
    {
        String procedimientoAlmacenado = "{ call REG_TEMA_X_SESION(?, ?)}";
        Connection cn = this.db.getConnection();

        if (cn != null) {
            try {
                for (Integer temaId : temasId) {
                    CallableStatement proc = cn.prepareCall(procedimientoAlmacenado);
                    proc.setInt("p_id_tema", temaId);
                    proc.setInt("p_id_sesion", sesionId);
                    proc.executeQuery();
                }
            } catch(SQLException ex) {
                return ex.getMessage();
            } finally {
                try {
                    cn.close();
                } catch (Exception e) {
                    return e.getMessage();
                }
            }
        }

        return "OK";
    }

    @Override
    public String insertarTemasExtras(List<String> temasExtras, Integer sesionId)
    {
        String procedimientoAlmacenado = "{ call REG_TEMA_ADICIONAL(?, ?)}";
        Connection cn = this.db.getConnection();

        if (cn != null) {
            try {
                for (String tema : temasExtras) {
                    CallableStatement proc = cn.prepareCall(procedimientoAlmacenado);
                    proc.setString("p_Descripcion", tema);
                    proc.setInt("p_IDSesion", sesionId);
                    proc.executeQuery();
                }
            } catch(SQLException ex) {
                ex.printStackTrace();
                return ex.getMessage();
            } finally {
                try {
                    cn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                    return e.getMessage();
                }
            }
        }

        return "OK";
    }

    @Override
    public Boolean obtenerSiValidoTemas(Integer idSesion, Integer idAlumno) {
        Boolean resultado = false;
        String procedimientoAlmacenado = "{ ? = call RET_VALIDO_TEMAS(?, ?)}";
        Connection cn = this.db.getConnection();

        if (cn != null) {
            try {
                CallableStatement proc = cn.prepareCall(procedimientoAlmacenado);
                proc.registerOutParameter("v_resultado", Types.INTEGER);
                proc.setInt("p_id_sesion", idSesion);
                proc.setInt("p_id_alumno", idAlumno);
                proc.executeQuery();

                resultado = (proc.getInt("v_resultado") > 0);
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

    @Override
    public String insertarValidacionDeTemas(List<Integer> temasId, Integer idSesion, Integer idAlumno)
    {
        String procObtenerTemaSesionId = "{ ? = call RET_TEMA_SESION_ID(?, ?) }";

        String procedimientoAlmacenado = "{ call REG_VALIDACION_TEMA(?, ?)}";
        Connection cn = this.db.getConnection();

        if (cn != null) {
            try {
                for (Integer temaId : temasId) {
                    CallableStatement procTemaSesion = cn.prepareCall(procObtenerTemaSesionId);
                    procTemaSesion.registerOutParameter("v_resultado", Types.INTEGER);
                    procTemaSesion.setInt("p_id_sesion", idSesion);
                    procTemaSesion.setInt("p_id_tema", temaId);
                    procTemaSesion.executeQuery();
                    Integer temaSesionId = procTemaSesion.getInt("v_resultado");

                    CallableStatement proc = cn.prepareCall(procedimientoAlmacenado);
                    proc.setInt("p_tema_sesion_id", temaSesionId);
                    proc.setInt("p_alumno_id", idAlumno);
                    proc.executeQuery();
                }
            } catch(SQLException ex) {
                ex.printStackTrace();
                return ex.getMessage();
            } finally {
                try {
                    cn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                    return e.getMessage();
                }
            }
        }

        return "OK";
    }

}
