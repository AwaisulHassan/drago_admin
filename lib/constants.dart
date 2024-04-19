import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);
const drawerBackground = Color(0xFF212332);
const hoverColor = Color(0xFFfe9f42);

const defaultPadding = 16.0;
const defaultBorderRadius = 10.0;
const defaultDrawerHeadHeight = 20.0;


// SIDE BAR SVG IMAGE
const DASHBOARD_SVG = "assets/icons/menu_dashboard.svg";



//firebase firestore
var firestore = FirebaseFirestore.instance;

class Constant{
  static const  KEY_PREFERENCE_NAME = "waomeAppPreference";
  static const  COLLECTION_USER = "users";
  static  const  COLLECTION_DEPOSIT = "deposit";
  static  const  COLLECTION_WITHDRAW = "withdraw";
  static  const  COLLECTION_TRANSFER = "transfer";
  static  const  COLLECTION_ANNOUNCEMENT = "annoucement";
  static  const  COLLECTION_CHATS = "chats";
  static const  KEY_USERUID = "userUID";
  static  const  KEY_FULLNAME = "fullName";
  static  const  KEY_USERNAME = "username";
  static  const  KEY_EMAIL = "email";
  static const  KEY_PASSWORD = "password";
  static const  KEY_TOKEN = "token";
  static const  KEY_DATE = "date";
  static const  KEY_TIME = "time";
  static const  KEY_REFERRAL_CODE = "referralCode";
  static const  KEY_TIMESTAMP = "timestamp";
  static const  KEY_ACCOUNT_METHOD = "accountMethod";
  static const  KEY_USER_VERIFIED = "userVerified";
  static const  KEY_PROFILE_PIC = "profilePicUrl";
  static const  KEY_PHONE_NUMBER = "phoneNumber";
  static const  KEY_STATUS = "status";
  static const  KEY_BINANCE_ID = "binanceID";
  static  const  KEY_URL = "url";
  static  const  KEY_DEPOSIT_METHOD = "depositMethod";
  static   const  KEY_ID = "id";
  static  const  KEY_AMOUNT = "amount";

  static  const  KEY_RECEIVER_ID = "receiverID";
  static const  KEY_RECEIVER_NAME = "receiverName";
  static const  KEY_RECEIVER_EMAIL = "receiverEmail";

  static const  KEY_WITHDRAW_METHOD = "withdrawMethod";

  static const  KEY_NOTIFICATION_TITLE = "title";
  static const  KEY_NOTIFICATION_MESSAGE = "message";
  static const  KEY_TYPE = "type";
  static const  KEY_ANNOUCEMENT_ID = "id";
  static const  KEY_ANNOUCEMENT_TITLE = "title";
  static const  KEY_ANNOUCEMENT_DESC = "desc";


  String getRelativeTimeWithDetails(int timestamp) {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    int elapsedTime = currentTime - timestamp;
    if (elapsedTime < 0) {
      return "Future date";
    } else if (elapsedTime < 60 * 1000) {
      return "Just now";
    } else if (elapsedTime < 2 * 60 * 1000) {
      return "A minute ago";
    } else if (elapsedTime < 60 * 60 * 1000) {
      return "${elapsedTime ~/ (60 * 1000)} minutes ago";
    } else if (elapsedTime < 2 * 60 * 60 * 1000) {
      return "An hour ago";
    } else if (elapsedTime < 24 * 60 * 60 * 1000) {
      return "${elapsedTime ~/ (60 * 60 * 1000)} hours ago";
    } else if (elapsedTime < 2 * 24 * 60 * 60 * 1000) {
      return "Yesterday";
    } else if ((elapsedTime ~/ (24 * 60 * 60 * 1000)) < 7) {
      return "${elapsedTime ~/ (24 * 60 * 60 * 1000)} days ago";
    } else {
      return formatDate(timestamp);
    }
  }

  String formatDate(int timestamp) {
    DateFormat sdf = DateFormat("d-MMM-yyyy");
    return sdf.format(DateTime.fromMillisecondsSinceEpoch(timestamp));
  }

  String formatTime(int timestamp) {
    DateFormat sdf = DateFormat('h:mm a');
    return sdf.format(DateTime.fromMillisecondsSinceEpoch(timestamp));
  }

}
