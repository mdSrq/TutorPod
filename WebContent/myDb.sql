create database tutorpod;
use tutorpod;
create table admin(admin_id int auto_increment primary key,
					name varchar(20) unique not null,
                    password varchar(20) not null,
					);
create table admin_bank_acc(admin_bank_acc_id int auto_increment primary key,
					admin_id int not null,
					bank_acc_id int not null,
					selected boolean default false
					);
create table user(user_id int auto_increment primary key,
					fname varchar(25) not null,
                    lname varchar(25),
                    username varchar(20) unique not null,
                    password varchar(20) not null,
                    email_id varchar(40) not null,
                    mobile_no varchar(13) not null,
                    gender enum('Male','Female','Other') not null,
                    photo varchar(20),
                    profile_status varchar(20) not null,
                    joining_date date not null,
                    tutor_id int ,
                    wallet_id int,
                    bank_acc_id int
					);
create table tutor(tutor_id int auto_increment primary key,
					photo varchar(20) not null,
                    bio varchar(150) not null,
                    approval_date date not null,
                    profile_status varchar(20) not null,
                    user_id int not null,
                    address_id int
					);
create table address(address_id int auto_increment primary key,
					street_address varchar(30) not null,
                    locality varchar(30) not null,
                    district varchar(20) not null,
                    state varchar(20) not null,
                    pin_code varchar(6) not null
					);
create table bank_acc(bank_acc_id int auto_increment primary key,
					bank_name varchar(20) not null,
                    acc_no varchar(20) unique not null,
                    holder_name varchar(30) not null,
                    ifsc_code varchar(15) not null,
                    balance long not null,
					);
create table achievement(achievement_id int auto_increment primary key,
					achivement_type varchar(15) not null,
                    title varchar(30) not null,
                    institution varchar(30),
                    location varchar(25),
                    description varchar(50),
                    start_year varchar(4),
                    end_year varchar(5)
					);
create table language(language_id int auto_increment primary key,
					language_name varchar(20) not null unique,
                    proficiency enum('Beginner','Intermediate','Fluent','Native') not null unique
					);
create table lang_info(lang_info_id int auto_increment primary key,
					tutor_id int not null,
                    language_id int not null
					);
create table course( course_id int auto_increment primary key,
					course_name varchar(80) unique not null,
                    name_abbr varchar(6) unique not null,
                    duration_type varchar(10) not null,
                    duration int not null
					);
create table subject(subject_id int auto_increment primary key,
					subject_name varchar(80) not null,
                    subject_code varchar(10) unique not null
					);
create table course_sub(course_sub_id int auto_increment primary key,
					course_id int not null,
                    duration_no int not null,
                    subject_id int not null,
                    constraint UC_course_sub unique(course_id,subject_id)
					);
create table subject_info(subject_info_id int auto_increment primary key,
					tutor_id int not null,
                    subject_id int not null,
                    teaching_level varchar(10)
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
create table fees(fee_id int auto_increment primary key,
					tutor_id int not null,
                    suject_id int not null,
                    duration double not null,
                    amount double not null
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
					notification varchar(20) not null
					);