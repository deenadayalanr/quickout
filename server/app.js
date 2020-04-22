const express = require("express")
const mysql = require("mysql2/promise")

let db = null;
const app = express()
app.use(express.json())

app.post('/create-user', async(req,res,next)=>{
    const email = req.body.email;
    const pass = req.body.password;
    await db.query("INSERT INTO users (email,password) VALUES (?,?);",[email,pass]);
    
    res.json({status:"OK"});
    next()
})

app.post('/formdata', async(req,res,next)=>{
    const email = req.body.email;
    const studentname = req.body.studentname;
    const department = req.body.department;
    const roomno = req.body.roomno;
    const indate = req.body.indate;
    const outdate = req.body.outdate;
    const reason = req.body.reason;
    const status = req.body.status;
    await db.query("INSERT INTO formdata (email,studentname,department,roomno,indate,outdate,reason,status) VALUES (?,?,?,?,?,?,?,?);",[email,studentname,department,roomno,indate,outdate,reason,status]);
    
    res.json({status:"OK"});
    next()
})

app.get('/form', async (req,res,next)=>{
    const [rows] = await db.query("SELECT * FROM formdata;")
    console.log(rows)
    res.json(rows)
    next()
})

app.put('/formdata', async(req,res,next)=>{
    const email = req.body.email;
    const status = req.body.status;
    await db.query("UPDATE formdata SET status = ? WHERE email = ?;",[status,email]);
    res.json({status:"OK"});
    next()
})

app.get('/users', async (req,res,next)=>{
    const [rows] = await db.query("SELECT * FROM users;")
    console.log(rows)
    res.json(rows)
    next()
})

async function main(){
    db = await mysql.createConnection({
        host: "127.0.0.1",
        port: "3307",
        user: "root",
        password: "",
        database: "quickoutnodejs",
        timezone: "+00:00",
        charset: "utf8mb4_general_ci",
    });
    app.listen(8000);
}

main();

