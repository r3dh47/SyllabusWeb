package com.junior.parser;

import org.json.JSONException;
import org.json.JSONObject;

import com.junior.to.Bibliografia;

public class BibliografiaJsonParser implements JsonParser<Bibliografia>{

    public Bibliografia parse(JSONObject object) throws JSONException
    {
        Bibliografia nuevoLibro = new Bibliografia();
        nuevoLibro.setAnioPublicacion(Integer.parseInt(object.getString("year")));
        nuevoLibro.setAutor(object.getString("author"));
        nuevoLibro.setEditorial(object.getString("editorial"));
        nuevoLibro.setTitulo(object.getString("title"));
        nuevoLibro.setIsbn(object.getString("isbn"));
        nuevoLibro.setLugarPublicacion(object.getString("lugar"));

        return nuevoLibro;
    }

}
