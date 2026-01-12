//to make your project artefacts unique
namespace com.invenio;

using {com.reuse} from './reuse';
using {
    cuid,
    temporal,
    managed
} from '@sap/cds/common';


context master {

    entity student : reuse.address {
        key id      : reuse.guuid;
            name    : String(80);
            //creating a foreign key - runtime column name will be class_id
            class   : Association to semester;
            backlog : Boolean;
            age     : Int16;
    }

    entity semester {
        key id             : reuse.guuid;
            semester       : String(40);
            specialization : String(40);
            hod            : String(80);
    }

    entity book {
        key id     : reuse.guuid;
            name   : String(80);
            author : String(90);
    }

}


context trans {
    entity subs : cuid, temporal, managed {
        student : Association to one master.student;
        book    : Association to one master.book;
    }
}
