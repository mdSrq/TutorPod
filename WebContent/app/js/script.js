const btnHamburger = document.querySelector("#btnHamburger");
const header = document.querySelector("#header");
const toggleOn = document.querySelectorAll(".toggle-on");
const dashboardDropdown = document.querySelectorAll(".sidebar__dropdown_title");
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
dashboardDropdown.forEach(item=>{
    item.addEventListener("click",()=>{
        console.log("Shit");
        let arrow;
        item.childNodes.forEach(e=>{
            if(e.classList!=null){
                 arrow = e;
            }
        });
        const links = item.nextSibling.nextSibling;
        console.log(links);
        console.log(arrow);
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
