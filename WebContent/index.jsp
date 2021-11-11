<%@include file="header.jsp" %>
<%if(session.getAttribute("USER")!=null){ %>
<div class="hide-for-desktop">
	<%@include file="sidebar.jsp" %>
</div>
<%}%>
<main>
    <section class="hero container">
        <div class="hero__illustration wide-for-mobile">
            <img src="./images/Hero_Illustration.svg" alt="" srcset="">
        </div>
        <form action="#" class="hero__action_tile wide-for-mobile" method="GET">
            <h1 class="thin-H1">Master Any Subject<br> With Online Tutors</h1>
            <p>Learn any subject at your time and anywhere.</p>
            <input type="search" class="hero__cta_search input-with-icon" name="searchBar" id="searchBar"
                placeholder="Search by Suject or Course" required>
            <input type="submit" class="button hero__cta flat-wide-button" value="Find a Tutor">
            <p class="hero__sugesstion">
                <strong>Popular: </strong>
                <a href="http://">BCA</a>,
                <a href="http://">Descrete Maths</a>,
                <a href="http://">C++</a>,
                <a href="http://">Java</a>
            </p>
        </form>
    </section>
    <div class="grid">
        <div class="content">
        </div>
    </div>
</main>
<script type="text/javascript">

</script>
<%@include file="footer.jsp" %>