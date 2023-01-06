
// 1*: Преобразовать написанный код в 26-33 пунктах в функцию, принимающую на вход возраст.

function showMessage(age) {
    if (age < 18) {
        console.log("You don’t have access cause your age is less than 18");
    } else if (age >= 18 && age < 60) {
        console.log("Welcome!");
    } else if (age >= 60) {
        console.log("Keep calm and look Culture channel");
    } else {
        console.log("Technical work");
    }
};

showMessage(17);
showMessage(18);
showMessage(61);

// 2*: Преобразовать задание 1* таким образом, чтобы первым делом в функции проверялся тип данных. 
// И если он не Number - кидалась ошибка.

function showMessage(age) {
    if (isNaN(age)) {              // не уверен, что работает правильно
        console.log("Error");
    } else if (age < 18) {
        console.log("You don’t have access cause your age is less than 18");
    } else if (age >= 18 && age < 60) {
        console.log("Welcome!");
    } else if (age >= 60) {
        console.log("Keep calm and look Culture channel");
    } else {
        console.log("Technical work");
    }
};
showMessage(17);
showMessage(18);
showMessage(61);

