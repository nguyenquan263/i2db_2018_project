var express = require('express');
var router = express.Router();
var db = require('../database_connection/db');

router.use(function (req, res, next) { next() });

router.post('/', function (req, res) {
    if (req.body.test_id && req.body.taking_id && req.body.taker_id) {
        db.query(`SELECT DISTINCT T2.TEST_ID, T2.TEST_NAME, T1.TAKER_ID, T1.TAKER_NAME, Q.QUESTION_ID, Q.EXPLANATION, Q.HAS_MULTIPLE_ANSWER, 
    (
        SELECT COUNT(A1.ANSWER_ID)
            FROM TAKINGS T1
            JOIN TAKERS T11
            ON T1.TAKER_ID = T11.TAKER_ID
            JOIN TESTS T21
            ON T21.TEST_ID = T1.TEST_ID
            JOIN SELECTIONS S1
            ON S1.TAKING_ID = T1.TAKING_ID
            JOIN ANSWERS A1
            ON A1.ANSWER_ID = S1.ANSWER_ID
            JOIN QUESTIONS Q1 
            ON Q1.QUESTION_ID = A1.QUESTION_ID
        WHERE T11.TAKER_ID = T.TAKER_ID
        AND Q1.QUESTION_ID = Q.QUESTION_ID
    ) AS NUM_CHOSEN,
    (
        SELECT COUNT(A1.ANSWER_ID)
            FROM TAKINGS T1
            JOIN TAKERS T11
            ON T1.TAKER_ID = T11.TAKER_ID
            JOIN TESTS T21
            ON T21.TEST_ID = T1.TEST_ID
            JOIN SELECTIONS S1
            ON S1.TAKING_ID = T1.TAKING_ID
            JOIN ANSWERS A1
            ON A1.ANSWER_ID = S1.ANSWER_ID
            JOIN QUESTIONS Q1 
            ON Q1.QUESTION_ID = A1.QUESTION_ID
        WHERE A1.IS_TRUE = 1
        AND T11.TAKER_ID = T.TAKER_ID
        AND Q1.QUESTION_ID = Q.QUESTION_ID
    ) AS NUM_CHOSEN_RIGHT,
    (
        SELECT COUNT(*) FROM ANSWERS A11 JOIN QUESTIONS Q11 
        ON A11.QUESTION_ID = Q11.QUESTION_ID 
        WHERE Q11.QUESTION_ID = Q.QUESTION_ID
        AND A11.IS_TRUE = 1
    ) AS NUM_RIGHT_ANSWER,
    
    CASE WHEN ((SELECT COUNT(A1.ANSWER_ID)
    FROM TAKINGS T1
    JOIN TAKERS T11
    ON T1.TAKER_ID = T11.TAKER_ID
    JOIN TESTS T21
    ON T21.TEST_ID = T1.TEST_ID
    JOIN SELECTIONS S1
    ON S1.TAKING_ID = T1.TAKING_ID
    JOIN ANSWERS A1
    ON A1.ANSWER_ID = S1.ANSWER_ID
    JOIN QUESTIONS Q1 
    ON Q1.QUESTION_ID = A1.QUESTION_ID
    WHERE A1.IS_TRUE = 1
    AND T11.TAKER_ID = T.TAKER_ID
    AND Q1.QUESTION_ID = Q.QUESTION_ID) = (SELECT COUNT(*) FROM ANSWERS A11 JOIN QUESTIONS Q11 
    ON A11.QUESTION_ID = Q11.QUESTION_ID 
    WHERE Q11.QUESTION_ID = Q.QUESTION_ID
    AND A11.IS_TRUE = 1)AND (SELECT COUNT(A1.ANSWER_ID)
    FROM TAKINGS T1
    JOIN TAKERS T11
    ON T1.TAKER_ID = T11.TAKER_ID
    JOIN TESTS T21
    ON T21.TEST_ID = T1.TEST_ID
    JOIN SELECTIONS S1
    ON S1.TAKING_ID = T1.TAKING_ID
    JOIN ANSWERS A1
    ON A1.ANSWER_ID = S1.ANSWER_ID
    JOIN QUESTIONS Q1 
    ON Q1.QUESTION_ID = A1.QUESTION_ID
    WHERE T11.TAKER_ID = T.TAKER_ID
    AND Q1.QUESTION_ID = Q.QUESTION_ID) = (SELECT COUNT(*) FROM ANSWERS A11 JOIN QUESTIONS Q11 
    ON A11.QUESTION_ID = Q11.QUESTION_ID 
    WHERE Q11.QUESTION_ID = Q.QUESTION_ID
    AND A11.IS_TRUE = 1)) THEN Q.SCORE ELSE 0 END AS SCORE_EARNED
    
    FROM TAKINGS T
    JOIN TAKERS T1
    ON T.TAKER_ID = T1.TAKER_ID
    JOIN TESTS T2
    ON T2.TEST_ID = T.TEST_ID
    JOIN SELECTIONS S
    ON S.TAKING_ID = T.TAKING_ID
    JOIN ANSWERS A
    ON A.ANSWER_ID = S.ANSWER_ID
    JOIN QUESTIONS Q 
    ON Q.QUESTION_ID = A.QUESTION_ID
    WHERE T.TAKING_TIME = ?
    AND T2.TEST_ID =? 
    AND T1.TAKER_ID = ?`, [req.body.taking_id, req.body.test_id, req.body.taker_id], function (err, result) {
                if (err) {
                    console.log(err);
                    res.send({ error: 1, message: 'Error of database' });
                }
                else {
                    //sum score.
                    var sum_score = 0
                    for (var i = 0; i < result.length; i++){
                        sum_score+= result[i].SCORE_EARNED;
                    }
                    res.send({ error: 0, total_score: sum_score, data: result, message: 'Your query excecuted completely'});
                }

            });
    }
    else {
        res.send({ error: 2, message: 'Error Mising field' });
    }

});

router.post("/set_score/:taking_id/:total_score", function(req, res){
    if (req.params.taking_id && req.params.total_score){
        db.query("UPDATE TAKINGS SET TOTAL_SCORE = ? WHERE TAKING_ID = ?", [req.params.total_score, req.params.taking_id], function(err, result){
            if (err) {
                res.send({ error: 1, message: 'Error of database' });
            }
            else {
                res.send({ error: 0, message: 'Update Complete' });
            }
        });
    } else {
        res.send({ error: 2, message: 'Error Mising field' });
    }
});
module.exports = router;