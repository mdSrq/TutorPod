<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./app/css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:ital,wght@0,200;0,300;0,400;0,600;0,700;0,800;0,900;1,200;1,300;1,400;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">   
    <title>Tutor Pod</title>
</head>
<body>
    <header class="header" id="header">
        <nav class="container flex flex-jc-sb flex-ai-c">
            <a href="/" class="header__logo flex flex-ai-c ">
                <img src="./images/TutorPod1.svg" alt="TutorPod">
              <span class="header__logo_title">Tutor<span class="header__logo_title_part">Pod</span> </span>
            </a>
            <a href="#" id="btnHamburger" class="header__menu hide-for-desktop">
                <span></span>
                <span></span>
                <span></span>
            </a>
            <div class="header__links hide-for-mobile">
                <a href="#" class="header__links_dropdown">Subjects <span class="dropdown-arrow">></span></a>
                <a href="#">Apply to Teach</a>
                <a href="#">Find a Tutor</a>
                <a href="# ">Other2</a>
                <a href="# ">Other3</a>
            </div>
            <a href="#" class="button hide-for-mobile">Sign Up</a>
        </nav>
        <div class="overlay toggle-on"></div>
        <div class="header__overlay_menu hide-for-desktop toggle-on" >
           <a href="http://">Home</a>
           <a href="http://">Apply to Teach</a>
           <a href="http://">Other1</a>
           <a href="http://">Other2</a>
           <a href="http://">Other3</a>
        </div>
    </header>