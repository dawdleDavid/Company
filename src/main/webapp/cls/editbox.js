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

function editbtn(id){
    // ta förra värdet från kaka
    let cookies = document.cookie; 
    $("#form-"+id.toString()).show(500);
    document.cookie = "selord="+id;
    // om det förra värdet är lika med det nuvarande, (inte bra implementering)
    if(cookies.includes("selord="+id)){
        $("#form-"+id.toString()).hide(500);
        document.cookie = "selord="+null;
    }
  
}