// function* generator() {
//     var index = 0;
//     while (true)
//         yield index++;
// }

// function* countAppleSales() {
//     var saleList = [3, 7, 5];
//     for (var i = 0; i < saleList.length; i++) {
//         yield saleList[i];
//     }
// }

// var gen = generator();

var x = 1;
function* foo() {
    x++;
    console.log("testing")
    yield;
    console.log("x", yield);
}

async function testing() {
    await Promise()
}
var it = foo();
setInterval(() => {
    it.next();
}, 5000);
// setInterval(() => {
//     console.log(gen.next().value)
// }, 5000);