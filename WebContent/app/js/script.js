const btnHamburger = document.querySelector("#btnHamburger");
const header = document.querySelector("#header");
const overlay = document.querySelector(".overlay");
btnHamburger.addEventListener("click",function(){
    header.classList.toggle("open");
    if(overlay.classList.contains("fade-in")){
        overlay.classList.remove("fade-in");
        overlay.classList.add("fade-out");
    }else{
        overlay.classList.remove("fade-out");
        overlay.classList.add("fade-in");
    }
});