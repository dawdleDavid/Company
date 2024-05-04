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
// funktion for att testa om man clickat element
 /*
$(window).on('scroll', function() { 
      var scrollPosition = $(this).scrollTop(); 
      $('#scroll').css('top', scrollPosition); 
});*/ 