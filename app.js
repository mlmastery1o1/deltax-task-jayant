var express = require("express");
var md5 = require("md5");
var multer = require('multer');
const con = require("./config/dbconfig");
var db = require('./config/dbconfig');

var app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static(__dirname + "/views"));
app.set("view engine", "ejs");

var HTTP_PORT = 8080;
// Start Server
app.listen(process.env.PORT || HTTP_PORT, () => {
  console.log("Server running on port %PORT%".replace("%PORT%", HTTP_PORT));
});

var storage = multer.diskStorage({
    destination: function(req, file, cb){
        cb(null, './public/uploads/')
    },
    filename: function (res, file, cb){
        cb(null, Date.now()+file.originalname)
    }
});
const fileFilter=(req, file, cb) =>{
    if(file.mimetype === 'image/jpeg' || file.mimetype === 'image/jpg' || file.mimetype === 'image/png'){
        cb(null, true);
    }else{
        cb(null, false);
    }
}

var upload = multer({
    storage:storage,
    fileFilter: fileFilter
});

app.get("/", (req,res, next)=>{
    res.render('index')
})

app.get("/add_song", (req,res, next)=>{
    res.render('add-song')
})

app.get("/get/artist", (req, res, next)=>{
    var sql = "SELECT artist_id, artist_name from artist"
    var values = []
    con.query(sql, values, (err, rows)=>{
        if (err) throw err;
        console.log(rows)
        res.status(200).send({'success' : true, 'result': rows})
    })
})

app.post("/add/song/poster", upload.single('myImg'), async (req, res, next) =>{
    if(req.file){
        const pathName = req.file.path;
        console.log(req.body.artist_select)
        var artists = req.body.artist_select.toString()
        sql = "INSERT INTO songs (song_name, song_release, song_poster, artists) VALUES (?,?,?,?)"
        values = [req.body.song_name, req.body.date_released, req.file.filename, artists]
        // res.status(200).json({'success' : true, 'result': req.file})
        con.query(sql, values, (err, rows)=>{
            if (err) throw err;
            res.redirect('/add-song')
            // res.status(200).json({'success' : true, 'result': req.body})
        })
    }
})

app.post("/add/artist", (req, res, next) =>{
    console.log(req.body)
    var sql = "INSERT INTO artist (artist_name, artist_dob, artist_bio) VALUES (?,?,?)"
    var values = [req.body.name,req.body.dob,req.body.bio]
    con.query(sql, values, (err, rows)=>{
        if (err) throw err;
        res.status(200).json({'success' : true, 'result': req.body})
    })
})

