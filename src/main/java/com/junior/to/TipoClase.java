package com.junior.to;

public class TipoClase {

    private Integer id;

    private String descripcion;

    public TipoClase(
            Integer id,
            String descripcion
            )
    {
        this.id = id;
        this.descripcion = descripcion;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDescripcion()
    {
        return descripcion;
    }

    public void setDescripcion(String descripcion)
    {
        this.descripcion = descripcion;
    }
}
