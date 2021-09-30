const btnHamburger = document.querySelector("#btnHamburger");
const header = document.querySelector("#header");
const toggleOn = document.querySelectorAll(".toggle-on");
btnHamburger.addEventListener("click",function(){
    header.classList.toggle("open");
    toggleOn.forEach(element=>{
        if(element.classList.contains("fade-in")){
            element.classList.remove("fade-in");
            element.classList.add("fade-out");
            document.querySelector("body").style="overflow:none";
        }else{
            element.classList.remove("fade-out");
            element.classList.add("fade-in");
            document.querySelector("body").style="overflow:hidden";
        }
    })
});