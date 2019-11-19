const express = require('express');
const router = express.Router();

const pool = require('../database');

router.get('/principal', (req, res) => {
    res.render('principal');
});

router.post('/principal', async (req, res) => {
    const rol = 'USUARIOGYM';
    const { nombres, apellidos, documento, codigo, fecha_nacimiento, edad, genero, celular, email,eps, rh, arl,alergia, c_alergia, pariente,
     tel_pariente, parentesco, hm1, hm1c,hm2,hm2c,hm3,hm4,hm5,hm6,hm6c,hm7,hm7c,hm8,hm9,hm9c,hm10,hm10c,hm10c2,hm11,hm11c,ha1,ha1c,ha2c,ha3c,ha4c,ha2,b1,b2,b3,b4,b5,b6} = req.body;
    const newPersona = {
        nombres,
        apellidos,
        documento,
        codigo,
        celular,
        email,
        rol
    };
    await pool.query('INSERT INTO persona set ?', [newPersona]);
    const persona = await pool.query('SELECT id FROM PERSONA WHERE CODIGO = ?', [codigo]);
    const id_persona = persona[0].id;
    const datos_per = {
        id_persona,
        fecha_nacimiento,
        edad,
        genero,
        eps,
        rh,
        arl,
        alergia,
        c_alergia,
        pariente,
        tel_pariente,
        parentesco
    };
    await pool.query('INSERT INTO datos_personales set ?', [datos_per]);
    const newHM_HA = {
        id_persona,
        hm1, 
        hm1c,
        hm2,
        hm2c,
        hm3,
        hm4,
        hm5,
        hm6,
        hm6c,
        hm7,
        hm7c,
        hm8,
        hm9,
        hm9c,
        hm10,
        hm10c,
        hm10c2,
        hm11,
        hm11c,
        ha1,
        ha1c,
        ha2c,
        ha3c,
        ha4c,
        ha2
    };
    await pool.query('INSERT INTO hm_ha set ?', [newHM_HA]);
    if (b1!==undefined) {
        await pool.query('INSERT INTO ben (id_persona, beneficio) VALUES ('+id_persona+',\''+b1+'\')');
    }
    if (b2!==undefined) {
        await pool.query('INSERT INTO ben (id_persona, beneficio) VALUES ('+id_persona+',\''+b2+'\')');
    }
    if (b3!==undefined) {
        await pool.query('INSERT INTO ben (id_persona, beneficio) VALUES ('+id_persona+',\''+b3+'\')');
    }
    if (b4!==undefined) {
        await pool.query('INSERT INTO ben (id_persona, beneficio) VALUES ('+id_persona+',\''+b4+'\')');
    }
    if (b5!==undefined) {
        await pool.query('INSERT INTO ben (id_persona, beneficio) VALUES ('+id_persona+',\''+b5+'\')');
    }
    if (b6!==undefined) {
        await pool.query('INSERT INTO ben (id_persona, beneficio) VALUES ('+id_persona+',\''+b6+'\')');
    }
    res.send('muy bien');
});

router.get('/principal2', async (req, res) => {
    const registrados = await pool.query('SELECT ID, NOMBRES, APELLIDOS, CODIGO FROM PERSONA');
    res.render('principal2', { registrados });
});

router.get('/registrado/:id', async (req, res) =>{
    const { id } = req.params;
    const formu = await pool.query('SELECT P.*, H.* FROM PERSONA P, HM_HA H WHERE P.ID = ? AND P.ID = H.PERSONA_ID', [id] );
    const bene = await pool.query('SELECT * FROM ben WHERE PERSONA_ID = ?', [id] );
    res.render('registrado', {form: formu[0], bene});
});

router.get('/c_rol', async (req, res) => {
    res.render('c_rol');
});

router.post('/c_rol', async (req, res) => {
    const { nombres, apellidos, documento, codigo, celular, email, rol} = req.body;
    const usuario = documento;
    const contrasena = codigo;
    const newrol = {
        nombres,
        apellidos,
        documento,
        codigo,
        celular,
        email,
        rol
    };
    await pool.query('INSERT INTO persona set ?', [newrol]);
    const persona = await pool.query('SELECT id FROM PERSONA WHERE CODIGO = ?', [codigo]);
    const id_persona = persona[0].id;
    await pool.query('INSERT INTO users (usuario, contrasena, id_persona) VALUES (\''+usuario+'\',\''+contrasena+'\','+id_persona+')');
    res.send('muy bien');
});

module.exports = router;