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
        cb(null, './views/public/uploads/')
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

app.get("/songs", (req,res, next)=>{
    res.render('songs')
})

app.get("/artist", (req,res, next)=>{
    res.render('artists')
})

app.get("/get/songs", (req,res, next)=>{
    var user_id = 2
    var sql = "SELECT * FROM songs;"
    var values = []
    con.query(sql, values, (err, rows)=>{
        if (err) throw err;
        var sql2 = "SELECT s.song_id, r.rating FROM songs s LEFT JOIN ratings r ON s.song_id=r.song_id where r.user_id=?;"
        var values2 = [user_id]
        con.query(sql2, values2, (err, rows2)=>{
            if (err) throw err;
            res.status(200).send({'success' : true, 'result': rows, 'ratings':rows2 })
        })
        
    })
})

app.get("/get/topsongs", (req,res, next)=>{
    var sql = "SELECT * FROM topsongs t JOIN song_artists a ON t.song_id=a.song_id JOIN artist art ON art.artist_id = a.artist_id Order BY avgrating DESC;"
    var values = []
    var artist={}
    con.query(sql, values, (err, rows)=>{
        if (err) throw err;
        var i=0
        var temp = 0
        while(i<rows.length){ //used for converting multivalued attribute to array
            artist[i] = []
            artist[i].push(rows[i].artist_name)
            for(let j=i+1; j<rows.length; j++){
                if(rows[i].song_id===rows[j].song_id){
                    artist[i].push(rows[j].artist_name)
                    console.log(i, j, rows[j].artist_name)
                    temp=j
                }
            }
            if(i<temp){
                i=temp+1
            }else{
                i = i+1
            }
        }
        console.log(artist)
        res.status(200).send({'success' : true, 'result': rows, 'artists': artist})
    })
})

app.get("/get/topartist", (req,res, next)=>{
    var sql = "SELECT * FROM topartists;"
    var values = []
    con.query(sql, values, (err, rows)=>{
        if (err) throw err;
        res.status(200).send({'success' : true, 'result': rows})
    })
})

app.get("/get/artist", (req, res, next)=>{
    var sql = "SELECT * from artist"
    var values = []
    con.query(sql, values, (err, rows)=>{
        if (err) throw err;
        res.status(200).send({'success' : true, 'result': rows})
    })
})

app.post("/add/song/poster", upload.single('myImg'), async (req, res, next) =>{
    if(req.file){
        const pathName = req.file.path;
        var user_id = 2
        var artists = req.body.artist_select
        var sql = "INSERT INTO songs (song_name, song_release, song_poster) VALUES (?,?,?)"
        var values = [req.body.song_name, req.body.date_released, req.file.filename]
        // res.status(200).json({'success' : true, 'result': req.file})
        console.log(artists)
        con.query(sql, values, (err, rows)=>{
            if (err) throw err;
                var sql2 = "INSERT INTO ratings (song_id, user_id, rating) VALUES (?,?,?)"
                var values2=[rows.insertId, user_id, 0]
                con.query(sql2, values2, (err, rows2)=>{
                    if (err) throw err;
                    artists.forEach(element => {
                        var sql3 = "INSERT INTO song_artists (song_id, artist_id) VALUES (?,?)"
                        values3 = [rows.insertId,element]
                        con.query(sql3, values3, (err, rows3)=>{
                            if (err) throw err;
                        })
                    });
                    res.redirect("/add_song")
                })
                
            // res.status(200).json({'success' : true, 'result': req.body})
        })
    }
})

app.post("/add/artist", (req, res, next) =>{
    
    var sql = "INSERT INTO artist (artist_name, artist_dob, artist_bio) VALUES (?,?,?)"
    var values = [req.body.name,req.body.dob,req.body.bio]
    con.query(sql, values, (err, rows)=>{
        if (err) throw err;
        res.status(200).json({'success' : true, 'result': req.body})
    })
})

app.post("/update/rating", (req, res, next) =>{
    user_id = 2
    var selsql = "SELECT * FROM ratings WHERE song_id=? AND user_id=?"
    var selvalues = [req.body.song_id,user_id]
    con.query(selsql, selvalues, (err, rows)=>{
        if(err) throw err;
        if(rows.length === 0){
            var instsql = "INSERT INTO ratings (song_id, user_id, rating) VALUES(?,?,?)"
            var instvalues = [req.body.song_id, user_id, req.body.song_rating]
            con.query(instsql, instvalues, (err, rows)=>{
                if(err) throw err;
                res.status(200).json({'success' : true, 'result': req.body})
            })
        }else{
            var sql = "UPDATE ratings SET rating=? WHERE song_id=? and user_id=?"
            var values = [req.body.song_rating, req.body.song_id,user_id]
            con.query(sql, values, (err, rows)=>{
                if (err) throw err;
                res.status(200).json({'success' : true, 'result': req.body})
            })
        }
    })
        
})
