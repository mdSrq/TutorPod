<%@include file="header.jsp" %>
<main>
    <section class="hero container">
        <div class="hero__illustration wide-for-mobile">
            <img src="./images/Hero_Illustration.svg" alt="" srcset="">
        </div>
        <form action="./SearchTutor" class="hero__action_tile wide-for-mobile" method="GET">
            <h1 class="thin-H1">Master Any Subject<br> With Online Tutors</h1>
            <p>Learn any subject at your time and anywhere.</p>
            <input type="search" class="hero__cta_search input-with-icon" name="keyword" id="searchBar"
                placeholder="Search by Suject Code or Subject Name" required>
            <input type="submit" class="button hero__cta flat-wide-button" value="Find a Tutor">
            <input type="hidden" name="searchBy" value="keyword">
            <p class="hero__sugesstion">
                <strong>Popular: </strong>
                <a href="./SearchTutor?searchBy=keyword&keyword=English">English</a>,
                <a href="./SearchTutor?searchBy=keyword&keyword=Discrete">Discrete Maths</a>,
                <a href="./SearchTutor?searchBy=keyword&keyword=Database">DBMS</a>,
                <a href="./SearchTutor?searchBy=keyword&keyword=Java">Java</a>
            </p>
        </form>
    </section>
</main>
<script type="text/javascript">

</script>
<%@include file="footer.jsp" %>