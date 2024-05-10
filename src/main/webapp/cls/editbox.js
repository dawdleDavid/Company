function rand(max) {
  return Math.floor(Math.random() * max);
}
// generera telefonsamtal
var intervalId = window.setInterval(function(){
    if(rand(10) === 2){
        console.log("phone call");
        
        // play phonecall sound
        document.getElementById('phone').play();
    }
}, 5000);
// "edit" knappen
<<<<<<< HEAD
// has to e rewritten
=======

>>>>>>> b2120d04b4420e9a9811bf79dbaa42708ec6569c
function editbtn(id){
    // ta förra värdet från kaka
    let cookies = document.cookie; 
    $("#form-"+id.toString()).show(500);
<<<<<<< HEAD
    
    $("#form-"+id.toString()).css('display', 'grid');
=======
>>>>>>> b2120d04b4420e9a9811bf79dbaa42708ec6569c
    document.cookie = "selord="+id;
    // om det förra värdet är lika med det nuvarande, (inte bra implementering)
    if(cookies.includes("selord="+id)){
        $("#form-"+id.toString()).hide(500);
        document.cookie = "selord="+null;
    }
  
}

function answerphone(id){
    var phone =  document.getElementById('phone');
    switch(id){
        case "busy":
            phone.pause();
            phone.currentTime = 0;;
            break;
    }
<<<<<<< HEAD
}
// set ordernumber cookie on form submission
function setCookie(key, value){
    document.cookie = ""+key+"="+value;
=======
>>>>>>> b2120d04b4420e9a9811bf79dbaa42708ec6569c
}