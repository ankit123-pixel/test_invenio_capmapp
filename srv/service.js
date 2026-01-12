const cds = require('@sap/cds');
const { SELECT } = require('@sap/cds/lib/ql/cds-ql');
const { to } = require('@sap/cds/lib/srv/cds-connect');
const { employees } = cds.entities("anubhav.db.master")
module.exports = function (srv) {

    srv.on('hello', function (req, res) {
        let name = req.data.name;
        return "Hello " + name;
    })

    srv.on('READ', 'ReadEmployeeSrv', async (req, res) => {
        let result = [];
        //Example 1: return hardcoded data
        result.push({
            "ID": "DUMMY",
            "nameFirst": "Sunil",
            "lastName": "Chhetri"
        })

        //Example 2 : return top 10 records
        result = cds.tx(req).run(SELECT.from(employees).limit(10));

        //Example 3 : return whos salary is greater than 90k
        result = cds.tx(req).run(SELECT.from(employees).limit(10).where(
            {
                salaryAmount: { '>=': 90000 }
            }
        ));

        //Example 4 : return total of salary where salary amount is greater than or equal to 90k
        result = await cds.tx(req).run(SELECT.from(employees).where(

            {
                salaryAmount: { '>=': 90000 }
            }
        ));
        var total = 0;
        for (let i = 0; i < result.length; i++) {
            const element = result[i];
            total = total + parseInt(element.salaryAmount);
        }
        result = total;
        return result;

    })
}