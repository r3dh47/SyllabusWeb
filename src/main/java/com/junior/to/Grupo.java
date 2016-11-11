package com.junior.to;

public class Grupo {
	
	private Integer id;
	
    private AsignaturaAperturadaTO asignaturaAperturada;

    private Integer numero;
    
    public Grupo(
    		Integer id, 
    		AsignaturaAperturadaTO asignaturaAperturada, 
    		Integer numero
    		) 
    {
		this.id = id;
		this.asignaturaAperturada = asignaturaAperturada;
		this.numero = numero;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

    public AsignaturaAperturadaTO getAsignaturaAperturada()
    {
        return asignaturaAperturada;
    }

	public void setAsignaturaAperturada(AsignaturaAperturadaTO asignaturaAperturada)
    {
        this.asignaturaAperturada = asignaturaAperturada;
    }

    public Integer getNumero()
    {
        return numero;
    }

    public void setNumero(Integer numero)
    {
        this.numero = numero;
    }
}
