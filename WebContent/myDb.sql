create database tutorpod;
use tutorpod;
create table admin(admin_id int auto_increment primary key,
					name varchar(20) unique not null,
                    password varchar(20) not null
					);
insert into admin(name,password) values('admin','admin');					
create table admin_bank_acc(admin_bank_acc_id int auto_increment primary key,
					admin_id int not null,
					bank_acc_id int not null,
					selected boolean default false,
					constraint UC_admin_bank_acc unique(admin_id,bank_acc_id)
					);
create table user(user_id int auto_increment primary key,
					fname varchar(25) not null,
                    lname varchar(25),
                    username varchar(20) unique not null,
                    password varchar(20) not null,
                    email_id varchar(255) unique not null,
                    mobile_no varchar(13) unique not null,
                    gender enum('Male','Female','Other') not null,
                    photo varchar(60),
                    joining_date date not null,
                    tutor_id int ,
                    wallet_id int,
                    bank_acc_id int,
                    FULLTEXT(fname,lname)
					);
create table tutor(tutor_id int auto_increment primary key,
                    bio varchar(300) not null,
                    approval_date date,
                    profile_status varchar(20) not null,
                    user_id int unique not null,
                    address_id int
					);
create table address(address_id int auto_increment primary key,
					street_address varchar(100) not null,
                    locality varchar(50) not null,
                    district varchar(50) not null,
                    city varchar(50) not null,
                    state varchar(50) not null, 
                    pincode varchar(6) not null,
                    constraint UC_address unique(street_address,locality,pincode)
					);
create table bank_acc(bank_acc_id int auto_increment primary key,
					bank_name varchar(50) not null,
                    acc_no varchar(20) not null,
                    holder_name varchar(50) not null,
                    ifsc_code varchar(15) not null,
                    balance long not null,
                    constraint UC_bank_acc unique(bank_name,acc_no,ifsc_code)
					);
create table experience(experience_id int auto_increment primary key,
					experience_type varchar(15) not null,
                    title varchar(30) not null,
                    institution varchar(80),
                    location varchar(25),
                    description varchar(300),
                    start_year varchar(4),
                    end_year varchar(5),
                    tutor_id int not null,
                    constraint UC_experience unique(title,start_year,tutor_id)
					);
create table language(language_id int auto_increment primary key,
					language_name varchar(20) not null unique
					);
insert into language(language_name) values('Hindi');
insert into language(language_name) values('English');
insert into language(language_name) values('Bengali');
insert into language(language_name) values('Marathi');
insert into language(language_name) values('Telugu');
insert into language(language_name) values('Tamil');
insert into language(language_name) values('Gujarati');
insert into language(language_name) values('Urdu');
insert into language(language_name) values('Kannada');
insert into language(language_name) values('Odia');
insert into language(language_name) values('Malayalam');
insert into language(language_name) values('Punjabi');
insert into language(language_name) values('Assamese');
insert into language(language_name) values('Maithili');
insert into language(language_name) values('Bhojpuri');
insert into language(language_name) values('Bhili/Bhilodi');
insert into language(language_name) values('Santali');
insert into language(language_name) values('Kashmiri');
insert into language(language_name) values('Nepali');
insert into language(language_name) values('Sindhi');
create table language_info(lang_info_id int auto_increment primary key,
					tutor_id int not null,
                    language_id int not null,
                    constraint UC_language_info unique(tutor_id,language_id)
					);
create table course( course_id int auto_increment primary key,
					course_name varchar(80) unique not null,
                    name_abbr varchar(6) unique not null,
                    duration_type varchar(10) not null,
                    duration int not null
					);
create table subject(subject_id int auto_increment primary key,
					subject_name varchar(80) not null,
                    subject_code varchar(10) unique not null,
                    FULLTEXT(subject_name)
					);
create table course_sub(course_sub_id int auto_increment primary key,
					course_id int not null,
                    duration_no int not null,
                    subject_id int not null,
                    constraint UC_course_sub unique(course_id,subject_id)
					);
create table wallet(wallet_id int auto_increment primary key,
					balance double ,
                    user_id int unique not null
					);
create table transaction( transaction_id int auto_increment primary key,
					payer enum('Admin','User') not null,
                    payer_id int not null,
                    receiver enum('Admin','User') not null,
                    receiver_id int not null,
                    amount double,
                    description varchar(40) not null,
                    date date not null,
                    datetime datetime not null
					);
create table fees(fees_id int auto_increment primary key,
					tutor_id int not null,
                    subject_id int not null,
                    fee double not null,
                    constraint UC_fees unique(tutor_id,subject_id)
					);
create table lesson(lesson_id int auto_increment primary key,
					booking_id int not null,
                    status varchar(10) not null,
                    meeting_link varchar(40) not null,
                    notes varchar(16)
                    );
create table availability (availability_id int auto_increment primary key,
					tutor_id int  not null,
					day_of_week int, /* 1 .. 7, null */ 
					avail_date Date, 
					time_from Time  not null,
					time_to Time  not null,
					constraint UC_availability_weekday unique(day_of_week,tutor_id),
					constraint UC_availability_date unique(avail_date,tutor_id),
					CHECK ((day_of_week IS NULL OR avail_date IS NULL) AND (day_of_week IS NOT NULL OR avail_date IS NOT NULL))
					);
create table booking(booking_id int auto_increment primary key,
					tutor_id int not null,
                    user_id int not null,
                    suject_id int not null,
                    duration double not null,
                    booking_type varchar(12) not null,
                    transaction_id int not null,
                    time_from Time not null,
                    time_to Time not null,
                    status varchar(10) not null
					);
create table withdraw_request(request_id int auto_increment primary key,
					wallet_id int not null,
                    amount double not null,
                    status varchar(10) not null,
					remarks varchar(30) 
					);
create table review(review_id int auto_increment primary key,
					no_of_stars int not null,
                    title varchar(30),
                    review varchar(150),
                    user_id int not null,
                    tutor_id int not null
					);
create table notification(notification_id int auto_increment primary key,
					notification varchar(150) not null,
                    link varchar(100) not null,
                    datetime datetime not null,
                    user_id int,
                    tutor_id int,
                    seen boolean not null,
                    clicked boolean not null,
                    CHECK ((user_id IS NULL OR tutor_id IS NULL) AND (user_id IS NOT NULL OR tutor_id IS NOT NULL))
					);