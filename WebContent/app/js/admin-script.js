const btnHamburger = document.querySelector("#btnHamburger");
const header = document.querySelector("#header");
const sidebardDropdown = document.querySelectorAll(".sidebar__dropdown_title");
const sidebar = document.querySelector(".sidebar");
btnHamburger.addEventListener("click",function(){
    header.classList.toggle("open");
        if(sidebar.classList.contains("slide-in")){
            sidebar.classList.remove("slide-in");
            sidebar.classList.add("slide-out");
        }else{
            sidebar.classList.remove("slide-out");
            sidebar.classList.add("slide-in");
        }
});
sidebardDropdown.forEach(item=>{
    item.addEventListener("click",()=>{
        let arrow;
        item.childNodes.forEach(e=>{
            if(e.classList!=null){
                 arrow = e;
            }
        });
        const links = item.nextSibling.nextSibling;
        if(links.classList.contains("reveal")){

            links.classList.remove("reveal");
            arrow.classList.remove("rotateBy90");

            links.classList.add("conceal");
            arrow.classList.add("rotateByNeg90");

        }else{

            links.classList.remove("conceal");
            arrow.classList.remove("rotateByNeg90");

            links.classList.add("reveal");
            arrow.classList.add("rotateBy90");
        }
        
    })
});
function showToast() {
  // Get the snackbar DIV
  var x = document.getElementById("snackbar");

  // Add the "show" class to DIV
  x.className = "show";

  // After 3 seconds, remove the show class from DIV
  setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
}
