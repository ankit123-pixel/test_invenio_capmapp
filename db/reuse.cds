namespace com.reuse;

//reusable type across allfiles of my project
type guuid : String(32);

//aspect is like structure
aspect address {
    city    : String(30);
    country : String(2);
    street  : String(32);

}
