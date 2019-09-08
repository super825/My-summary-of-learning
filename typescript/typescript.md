# Typescript 介绍

## 一、Typescript 简介

* Typescript 是微软开发的 Javascript 的超集，Typescript 兼容 Javascript，可以载入 Javascript 代码然后运行。

## 二、Typescript 与 Javascript 比较

* Typescript 与 Javascript 相比，进步的地方包括：加入注释，让编译器理解所支持的对象和函数，编译器会移除注释，不会增加开销；增加一个完整的类结构，使之更新是传统的面向对象语言。

## 三、语法特性

* 基础类型
* 变量声明
* 接口
* 类
* 函数
* 泛型
* 枚举
* 类型推论
* 类型兼容性
* 高级类型
* Symbols
* 迭代器和生成器
* 模块
* 命名空间
* 命名空间和模块
* 模块解析
* 声明合并
* JSX
* 装饰器
* Mixins
* 三斜线指令

## 四、参考资料

* 官网：http://www.typescriptlang.org/
* 官方手册：http://www.typescriptlang.org/docs/handbook/basic-types.html
* 中文官网手册：https://www.tslang.cn/docs/handbook/basic-types.html

# Mac OS X 下 TypeScript 开发环境搭建

## 一、集成开发环境

* WebStrom
* VSCode

## 二、安装 TypeScript

* Homebrew（macOS 缺失的软件包管理器）

```bash
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

* npm(Node Package Manager)，是 Nodejs 的包管理器

```bash
brew install node
```

* Typescript

```bash
npm install -g typescript
```

# Windows 环境下 TypeScript 开发环境搭建

## 一、集成开发环境

* WebStrom
* VSCode

## 二、安装 TypeScript

* nodejs 安装包：http://nodejs.cn/download/
* typescript

```bash
npm install -g typescript
```

# Typescript 基本数据类型

## 一、基本数据类型

* Boolean
* Number
* String
* Array
* Tuple
* Enum
* Any
* Void
* Null 和 Undefined
* Never

## 二、代码示例

```typescript
//布尔值
let isDone: boolean = false;

//数字(可以是二进制、八进制、十六进制)
let decLiteral: number = 6;
let hexLiteral: number = 0xf00d;
let binaryLiteral: number = 0b1010;
let octalLiteral: number = 0o744;

//字符串
let name: string = "bob";
name = "smith";

//使用模版字符串
let name: string = `Gene`;
let age: number = 37;
let sentence: string = `Hello, my name is ${name}.
I'll be ${age + 1} years old next month.`;

//数组
let list: number[] = [1, 2, 3];
//Array<元素类型>
let list: Array<number> = [1, 2, 3];

//元组 Tuple
// Declare a tuple type
let x: [string, number];
// Initialize it
x = ["hello", 10]; // OK
// Initialize it incorrectly
x = [10, "hello"]; // Error

//枚举
enum Color {
    Red,
    Green,
    Blue
}
let c: Color = Color.Green;

enum Color {
    Red = 1,
    Green,
    Blue
}
let c: Color = Color.Green;

enum Color {
    Red = 1,
    Green = 2,
    Blue = 4
}
let c: Color = Color.Green;

enum Color {
    Red = 1,
    Green,
    Blue
}
let colorName: string = Color[2];
alert(colorName); // 显示'Green'因为上面代码里它的值是2

//Any
let notSure: any = 4;
notSure = "maybe a string instead";
notSure = false; // okay, definitely a boolean

//Any数组
let list: any[] = [1, true, "free"];
list[1] = 100;

//Void
function warnUser(): void {
    alert("This is my warning message");
}
let unusable: void = undefined;

//Null 和 Undefined
let u: undefined = undefined;
let n: null = null;

//Never
// 返回never的函数必须存在无法达到的终点
function error(message: string): never {
    throw new Error(message);
}
// 推断的返回值类型为never
function fail() {
    return error("Something failed");
}
// 返回never的函数必须存在无法达到的终点
function infiniteLoop(): never {
    while (true) {}
}

//类型断言
let someValue1: any = "this is a string";
let strLength1: number = (someValue1 as string).length;

let someValue: any = "this is a string";
let strLength: number = (<string>someValue).length;
```

# 变量声明

## 一、let 和 const

* let 和 const 是 JavaScript 里相对较新的变量声明方式。 let 在很多方面与 var 是相似的，但是可以帮助大家避免在 JavaScript 里常见一些问题（如作用域提升）。 const 是对 let 的一个增强，它能阻止对一个变量再次赋值。

* 因为 TypeScript 是 JavaScript 的超集，所以它本身就支持 let 和 const。 推荐使用它们来代替 var。

* 使用最小特权原则，所有变量除了你计划去修改的都应该使用 const。

## 二、代码示例

```typescript
//块级作用域变量的获取
function theCityThatAlwaysSleeps() {
    let getCity;

    if (true) {
        let city = "Seattle";
        getCity = function() {
            return city;
        };
    }

    return getCity();
}

//重定义及屏蔽，这个版本的循环能得到正确的结果，因为内层循环的i可以屏蔽掉外层循环的i
function sumMatrix(matrix: number[][]) {
    let sum = 0;
    for (let i = 0; i < matrix.length; i++) {
        var currentRow = matrix[i];
        for (let i = 0; i < currentRow.length; i++) {
            sum += currentRow[i];
        }
    }

    return sum;
}

//const 声明
const numLivesForCat = 9;
const kitty = {
    name: "Aurora",
    numLives: numLivesForCat
};
// Error
kitty = {
    name: "Danielle",
    numLives: numLivesForCat
};
// all "okay"
kitty.name = "Rory";
kitty.name = "Kitty";
kitty.name = "Cat";
kitty.numLives--;
```

## 三、解构

* 解构数组

```typescript
//最简单的解构
let input = [1, 2];
let [first, second] = input;
console.log(first); // outputs 1
console.log(second); // outputs 2

// 交换变量
[first, second] = [second, first];

//作用于函数参数
function f([first, second]: [number, number]) {
    console.log(first);
    console.log(second);
}
f(input);

//数组里使用...语法创建剩余变量
let [first, ...rest] = [1, 2, 3, 4];
console.log(first); // outputs 1
console.log(rest); // outputs [ 2, 3, 4 ]

//忽略你不关心的尾随元素
let [first] = [1, 2, 3, 4];
console.log(first); // outputs 1
let [, second, , fourth] = [1, 2, 3, 4];
```

* 对象解构

```typescript
//对象解构
let o = {
    a: "foo",
    b: 12,
    c: "bar"
};
let { a, b } = o;

//就像数组解构，你可以用没有声明的赋值
({ a, b } = { a: "baz", b: 101 });

//你可以在对象里使用...语法创建剩余变量
let { a, ...passthrough } = o;
let total = passthrough.b + passthrough.c.length;
```

* 属性重命名

```typescript
//你也可以给属性以不同的名字
let { a: newName1, b: newName2 } = o;
```

* 默认值

```typescript
//默认值可以让你在属性为 undefined 时使用缺省值
function keepWholeObject(wholeObject: { a: string; b?: number }) {
    let { a, b = 1001 } = wholeObject;
}
```

* 函数声明

```typescript
//解构也能用于函数声明
type C = { a: string; b?: number };
function f({ a, b }: C): void {
    // ...
}
```

* 展开

```typescript
//将一个数组展开为另一个数组
let first = [1, 2];
let second = [3, 4];
let bothPlus = [0, ...first, ...second, 5];

//将一个对象展开为另一个对象
let defaults = { food: "spicy", price: "$$", ambiance: "noisy" };
let search = { ...defaults, food: "rich" };
//注意：如果前后对象有相同的属性，则后面的覆盖前面的
```

# 接口

## 一、介绍

* TypeScript 的核心原则之一是对值所具有的结构进行类型检查。 它有时被称做“鸭式辨型法”或“结构性子类型化”。 在 TypeScript 里，接口的作用就是为这些类型命名和为你的代码或第三方代码定义契约

## 二、接口初探

```typescript
interface LabelledValue {
    label: string;
}

function printLabel(labelledObj: LabelledValue) {
    console.log(labelledObj.label);
}

let myObj = { size: 10, label: "Size 10 Object" };
printLabel(myObj);
```

## 三、可选属性

```typescript
interface SquareConfig {
    color?: string;
    width?: number;
}

function createSquare(config: SquareConfig): { color: string; area: number } {
    let newSquare = { color: "white", area: 100 };
    if (config.color) {
        newSquare.color = config.color;
    }
    if (config.width) {
        newSquare.area = config.width * config.width;
    }
    return newSquare;
}

let mySquare = createSquare({ color: "black" });
```

## 四、只读属性

* readonly

```typescript
interface Point {
    readonly x: number;
    readonly y: number;
}
```

* ReadonlyArray<T>类型

```typescript
let a: number[] = [1, 2, 3, 4];
let ro: ReadonlyArray<number> = a;
ro[0] = 12; // error!
ro.push(5); // error!
ro.length = 100; // error!
a = ro; // error!
```

* readonly vs const
  * 最简单判断该用 readonly 还是 const 的方法：是看要把它做为变量使用还是做为一个属性。 做为变量使用的话用 const，若做为属性则使用 readonly。

## 五、额外的属性检查

```typescript
interface SquareConfig {
    color?: string;
    width?: number;
}

function createSquare(config: SquareConfig): { color: string; area: number } {
    // ...
}

// error: 'colour' not expected in type 'SquareConfig'
let mySquare = createSquare({ colour: "red", width: 100 });
```

## 六、函数类型

* 接口能够描述 JavaScript 中对象拥有的各种各样的外形。 除了描述带有属性的普通对象外，接口也可以描述函数类型。

* 为了使用接口表示函数类型，我们需要给接口定义一个调用签名。 它就像是一个只有参数列表和返回值类型的函数定义。参数列表里的每个参数都需要名字和类型。

```typescript
//使用接口表示函数类型
interface SearchFunc {
    (source: string, subString: string): boolean;
}

//使用这个函数类型的接口，创建一个函数类型的变量，并将一个同类型的函数赋值给这个变量
let mySearch: SearchFunc;
mySearch = function(source: string, subString: string) {
    let result = source.search(subString);
    return result > -1;
};
```

## 七、可索引的类型

* 与使用接口描述函数类型差不多，我们也可以描述那些能够“通过索引得到”的类型，比如 a[10]或 ageMap["daniel"]。 可索引类型具有一个 索引签名，它描述了对象索引的类型，还有相应的索引返回值类型。

```typescript
interface StringArray {
    [index: number]: string;
}
let myArray: StringArray;
myArray = ["Bob", "Fred"];
let myStr: string = myArray[0];

//字符串索引签名能够很好的描述dictionary模式，并且它们也会确保所有属性与其返回值类型相匹配。
interface NumberDictionary {
    [index: string]: number;
    length: number; // 可以，length是number类型
    name: string; // 错误，`name`的类型与索引类型返回值的类型不匹配
}

//你可以将索引签名设置为只读，这样就防止了给索引赋值
interface ReadonlyStringArray {
    readonly [index: number]: string;
}
let myArray: ReadonlyStringArray = ["Alice", "Bob"];
myArray[2] = "Mallory"; // error!
```

## 八、类类型

* 实现接口

```typescript
//与C#或Java里接口的基本作用一样，TypeScript也能够用它来明确的强制一个类去符合某种契约。
interface ClockInterface {
    currentTime: Date;
}

class Clock implements ClockInterface {
    currentTime: Date;
    constructor(h: number, m: number) {}
}

//你也可以在接口中描述一个方法，在类里实现它，如同下面的setTime方法一样
interface ClockInterface {
    currentTime: Date;
    setTime(d: Date);
}

class Clock implements ClockInterface {
    currentTime: Date;
    setTime(d: Date) {
        this.currentTime = d;
    }
    constructor(h: number, m: number) {}
}
//PS:接口描述了类的公共部分，而不是公共和私有两部分。 它不会帮你检查类是否具有某些私有成员
```

## 九、继承接口

```typescript
//和类一样，接口也可以相互继承
interface Shape {
    color: string;
}

interface Square extends Shape {
    sideLength: number;
}

let square = <Square>{};
square.color = "blue";
square.sideLength = 10;

//一个接口可以继承多个接口，创建出多个接口的合成接口
interface Shape {
    color: string;
}

interface PenStroke {
    penWidth: number;
}

interface Square extends Shape, PenStroke {
    sideLength: number;
}

let square = <Square>{};
square.color = "blue";
square.sideLength = 10;
square.penWidth = 5.0;
```

## 十、混合类型

```typescript
//一个对象可以同时做为函数和对象使用，并带有额外的属性
interface Counter {
    (start: number): string;
    interval: number;
    reset(): void;
}

function getCounter(): Counter {
    let counter = <Counter>function(start: number) {};
    counter.interval = 123;
    counter.reset = function() {};
    return counter;
}

let c = getCounter();
c(10);
c.reset();
c.interval = 5.0;
```

## 十一、接口继承类

* 当接口继承了一个类类型时，它会继承类的成员但不包括其实现。 就好像接口声明了所有类中存在的成员，但并没有提供具体实现一样。 接口同样会继承到类的 private 和 protected 成员。 这意味着当你创建了一个接口继承了一个拥有私有或受保护的成员的类时，这个接口类型只能被这个类或其子类所实现（implement）

```typescript
class Control {
    private state: any;
}

interface SelectableControl extends Control {
    select(): void;
}

class Button extends Control implements SelectableControl {
    select() {}
}

class TextBox extends Control {}

// 错误：“Image”类型缺少“state”属性。
class Image implements SelectableControl {
    select() {}
}

class Location {}
```

# 类

## 介绍

* 传统的 JavaScript 程序使用函数和基于原型的继承来创建可重用的组件，但对于熟悉使用面向对象方式的程序员来讲就有些棘手，因为他们用的是基于类的继承并且对象是由类构建出来的。 从 ECMAScript 2015，也就是 ECMAScript 6 开始，JavaScript 程序员将能够使用基于类的面向对象的方式。 使用 TypeScript，我们允许开发者现在就使用这些特性，并且编译后的 JavaScript 可以在所有主流浏览器和平台上运行，而不需要等到下个 JavaScript 版本

## 类

```typescript
class Greeter {
    greeting: string;
    constructor(message: string) {
        this.greeting = message;
    }
    greet() {
        return "Hello, " + this.greeting;
    }
}

let greeter = new Greeter("world");
```

## 继承

```typescript
class Animal {
    name: string;
    constructor(theName: string) {
        this.name = theName;
    }
    move(distanceInMeters: number = 0) {
        console.log(`${this.name} moved ${distanceInMeters}m.`);
    }
}

class Snake extends Animal {
    constructor(name: string) {
        super(name);
    }
    move(distanceInMeters = 5) {
        console.log("Slithering...");
        super.move(distanceInMeters);
    }
}

class Horse extends Animal {
    constructor(name: string) {
        super(name);
    }
    move(distanceInMeters = 45) {
        console.log("Galloping...");
        super.move(distanceInMeters);
    }
}

let sam = new Snake("Sammy the Python");
let tom: Animal = new Horse("Tommy the Palomino");

sam.move();
tom.move(34);
```

## 公共，私有与受保护的修饰符

* 默认为 public
* 当成员被标记成 private 时，它就不能在声明它的类的外部访问
* protected 修饰符与 private 修饰符的行为很相似，但有一点不同， protected 成员在派生类中仍然可以访问

```typescript
class Person {
    protected name: string;
    protected constructor(theName: string) {
        this.name = theName;
    }
}

// Employee 能够继承 Person
class Employee extends Person {
    private department: string;

    constructor(name: string, department: string) {
        super(name);
        this.department = department;
    }

    public getElevatorPitch() {
        return `Hello, my name is ${this.name} and I work in ${
            this.department
        }.`;
    }
}

let howard = new Employee("Howard", "Sales");
let john = new Person("John"); // 错误: 'Person' 的构造函数是被保护的.
```

## readonly 修饰符

* 你可以使用 readonly 关键字将属性设置为只读的。 只读属性必须在声明时或构造函数里被初始化

```typescript
class Octopus {
    readonly name: string;
    readonly numberOfLegs: number = 8;
    constructor(theName: string) {
        this.name = theName;
    }
}
let dad = new Octopus("Man with the 8 strong legs");
dad.name = "Man with the 3-piece suit"; // 错误! name 是只读的.
```

## 参数属性

```typescript
class Animal {
    constructor(private name: string) {}
    move(distanceInMeters: number) {
        console.log(`${this.name} moved ${distanceInMeters}m.`);
    }
}
```

## 存取器

```typescript
let passcode = "secret passcode";

class Employee {
    private _fullName: string;

    get fullName(): string {
        return this._fullName;
    }

    set fullName(newName: string) {
        if (passcode && passcode == "secret passcode") {
            this._fullName = newName;
        } else {
            console.log("Error: Unauthorized update of employee!");
        }
    }
}

let employee = new Employee();
employee.fullName = "Bob Smith";
if (employee.fullName) {
    alert(employee.fullName);
}
```

* 对于存取器有下面几点需要注意的：

  * 首先，存取器要求你将编译器设置为输出 ECMAScript 5 或更高。 不支持降级到 ECMAScript 3。 其次，只带有 get 不带有 set 的存取器自动被推断为 readonly。 这在从代码生成 .d.ts 文件时是有帮助的，因为利用这个属性的用户会看到不允许够改变它的值

## 静态属性

```typescript
class Grid {
    static origin = { x: 0, y: 0 };
    calculateDistanceFromOrigin(point: { x: number; y: number }) {
        //这里我们使用 Grid.来访问静态属性
        let xDist = point.x - Grid.origin.x;
        let yDist = point.y - Grid.origin.y;
        return Math.sqrt(xDist * xDist + yDist * yDist) / this.scale;
    }
    constructor(public scale: number) {}
}

let grid1 = new Grid(1.0); // 1x scale
let grid2 = new Grid(5.0); // 5x scale

console.log(grid1.calculateDistanceFromOrigin({ x: 10, y: 10 }));
console.log(grid2.calculateDistanceFromOrigin({ x: 10, y: 10 }));
```

## 抽象类

* 抽象类做为其它派生类的基类使用。 它们一般不会直接被实例化。 不同于接口，抽象类可以包含成员的实现细节。 abstract 关键字是用于定义抽象类和在抽象类内部定义抽象方法

* 抽象类中的抽象方法不包含具体实现并且必须在派生类中实现。 抽象方法的语法与接口方法相似。 两者都是定义方法签名但不包含方法体。 然而，抽象方法必须包含 abstract 关键字并且可以包含访问修饰符

```typescript
abstract class Department {
    constructor(public name: string) {}

    printName(): void {
        console.log("Department name: " + this.name);
    }

    abstract printMeeting(): void; // 必须在派生类中实现
}

class AccountingDepartment extends Department {
    constructor() {
        super("Accounting and Auditing"); // 在派生类的构造函数中必须调用 super()
    }

    printMeeting(): void {
        console.log("The Accounting Department meets each Monday at 10am.");
    }

    generateReports(): void {
        console.log("Generating accounting reports...");
    }
}

let department: Department; // 允许创建一个对抽象类型的引用
department = new Department(); // 错误: 不能创建一个抽象类的实例
department = new AccountingDepartment(); // 允许对一个抽象子类进行实例化和赋值
department.printName();
department.printMeeting();
department.generateReports(); // 错误: 方法在声明的抽象类中不存在
```

* 把类当做接口使用

```typescript
class Point {
    x: number;
    y: number;
}

interface Point3d extends Point {
    z: number;
}

let point3d: Point3d = { x: 1, y: 2, z: 3 };
```

# 函数

## 介绍

* 函数是 JavaScript 应用程序的基础。 它帮助你实现抽象层，模拟类，信息隐藏和模块。 在 TypeScript 里，虽然已经支持类，命名空间和模块，但函数仍然是主要的定义 行为的地方。 TypeScript 为 JavaScript 函数添加了额外的功能，让我们可以更容易地使用。

## 函数

* 和 JavaScript 一样，TypeScript 函数可以创建有名字的函数和匿名函数。 你可以随意选择适合应用程序的方式，不论是定义一系列 API 函数还是只使用一次的函数。

* 通过下面的例子可以迅速回想起这两种 JavaScript 中的函数：

```typescript
// Named function
function add(x, y) {
    return x + y;
}

// Anonymous function
let myAdd = function(x, y) {
    return x + y;
};
```

* 在 JavaScript 里，函数可以使用函数体外部的变量。 当函数这么做时，我们说它‘捕获’了这些变量。 至于为什么可以这样做以及其中的利弊超出了本文的范围，但是深刻理解这个机制对学习 JavaScript 和 TypeScript 会很有帮助。

```typescript
let z = 100;

function addToZ(x, y) {
    return x + y + z;
}
```

## 函数类型

### 为函数定义类型

* 让我们为上面那个函数添加类型：

```typescript
function add(x: number, y: number): number {
    return x + y;
}

let myAdd = function(x: number, y: number): number {
    return x + y;
};
```

* 我们可以给每个参数添加类型之后再为函数本身添加返回值类型。 TypeScript 能够根据返回语句自动推断出返回值类型，因此我们通常省略它。

### 书写完整函数类型

* 现在我们已经为函数指定了类型，下面让我们写出函数的完整类型。

```typescript
let myAdd: (x: number, y: number) => number = function(
    x: number,
    y: number
): number {
    return x + y;
};
```

* 函数类型包含两部分：参数类型和返回值类型。 当写出完整函数类型的时候，这两部分都是需要的。 我们以参数列表的形式写出参数类型，为每个参数指定一个名字和类型。 这个名字只是为了增加可读性。 我们也可以这么写：

```typescript
let myAdd: (baseValue: number, increment: number) => number = function(
    x: number,
    y: number
): number {
    return x + y;
};
```

* 只要参数类型是匹配的，那么就认为它是有效的函数类型，而不在乎参数名是否正确。

* 第二部分是返回值类型。 对于返回值，我们在函数和返回值类型之前使用( =>)符号，使之清晰明了。 如之前提到的，返回值类型是函数类型的必要部分，如果函数没有返回任何值，你也必须指定返回值类型为 void 而不能留空。

* 函数的类型只是由参数类型和返回值组成的。 函数中使用的捕获变量不会体现在类型里。 实际上，这些变量是函数的隐藏状态并不是组成 API 的一部分。

### 推断类型

* 尝试这个例子的时候，你会发现如果你在赋值语句的一边指定了类型但是另一边没有类型的话，TypeScript 编译器会自动识别出类型：

```typescript
// myAdd has the full function type
let myAdd = function(x: number, y: number): number {
    return x + y;
};

// The parameters `x` and `y` have the type number
let myAdd: (baseValue: number, increment: number) => number = function(x, y) {
    return x + y;
};
```

* 这叫做“按上下文归类”，是类型推论的一种。 它帮助我们更好地为程序指定类型。

### 可选参数和默认参数

* TypeScript 里的每个函数参数都是必须的。 这不是指不能传递 null 或 undefined 作为参数，而是说编译器检查用户是否为每个参数都传入了值。 编译器还会假设只有这些参数会被传递进函数。 简短地说，传递给一个函数的参数个数必须与函数期望的参数个数一致。

```typescript
function buildName(firstName: string, lastName: string) {
    return firstName + " " + lastName;
}

let result1 = buildName("Bob"); // error, too few parameters
let result2 = buildName("Bob", "Adams", "Sr."); // error, too many parameters
let result3 = buildName("Bob", "Adams"); // ah, just right
```

JavaScript 里，每个参数都是可选的，可传可不传。 没传参的时候，它的值就是 undefined。 在 TypeScript 里我们可以在参数名旁使用 ?实现可选参数的功能。 比如，我们想让 last name 是可选的：

```typescript
function buildName(firstName: string, lastName?: string) {
    if (lastName) return firstName + " " + lastName;
    else return firstName;
}

let result1 = buildName("Bob"); // works correctly now
let result2 = buildName("Bob", "Adams", "Sr."); // error, too many parameters
let result3 = buildName("Bob", "Adams"); // ah, just right
```

* 可选参数必须跟在必须参数后面。 如果上例我们想让 first name 是可选的，那么就必须调整它们的位置，把 first name 放在后面。

* 在 TypeScript 里，我们也可以为参数提供一个默认值当用户没有传递这个参数或传递的值是 undefined 时。 它们叫做有默认初始化值的参数。 让我们修改上例，把 last name 的默认值设置为"Smith"。

```typescript
function buildName(firstName: string, lastName = "Smith") {
    return firstName + " " + lastName;
}

let result1 = buildName("Bob"); // works correctly now, returns "Bob Smith"
let result2 = buildName("Bob", undefined); // still works, also returns "Bob Smith"
let result3 = buildName("Bob", "Adams", "Sr."); // error, too many parameters
let result4 = buildName("Bob", "Adams"); // ah, just right
```

* 在所有必须参数后面的带默认初始化的参数都是可选的，与可选参数一样，在调用函数的时候可以省略。 也就是说可选参数与末尾的默认参数共享参数类型。

```typescript
function buildName(firstName: string, lastName?: string) {
    // ...
}
```

```typescript
function buildName(firstName: string, lastName = "Smith") {
    // ...
}
```

* 共享同样的类型`(firstName: string, lastName?: string) => string`。 默认参数的默认值消失了，只保留了它是一个可选参数的信息。

* 与普通可选参数不同的是，带默认值的参数不需要放在必须参数的后面。 如果带默认值的参数出现在必须参数前面，用户必须明确的传入 undefined 值来获得默认值。 例如，我们重写最后一个例子，让 firstName 是带默认值的参数：

```typescript
function buildName(firstName = "Will", lastName: string) {
    return firstName + " " + lastName;
}

let result1 = buildName("Bob"); // error, too few parameters
let result2 = buildName("Bob", "Adams", "Sr."); // error, too many parameters
let result3 = buildName("Bob", "Adams"); // okay and returns "Bob Adams"
let result4 = buildName(undefined, "Adams"); // okay and returns "Will Adams"
```

### 剩余参数

* 必要参数，默认参数和可选参数有个共同点：它们表示某一个参数。 有时，你想同时操作多个参数，或者你并不知道会有多少参数传递进来。 在 JavaScript 里，你可以使用 arguments 来访问所有传入的参数。

* 在 TypeScript 里，你可以把所有参数收集到一个变量里：

```typescript
function buildName(firstName: string, ...restOfName: string[]) {
    return firstName + " " + restOfName.join(" ");
}

let employeeName = buildName("Joseph", "Samuel", "Lucas", "MacKinzie");
```

* 剩余参数会被当做个数不限的可选参数。 可以一个都没有，同样也可以有任意个。 编译器创建参数数组，名字是你在省略号（ ...）后面给定的名字，你可以在函数体内使用这个数组。

* 这个省略号也会在带有剩余参数的函数类型定义上使用到：

```typescript
function buildName(firstName: string, ...restOfName: string[]) {
    return firstName + " " + restOfName.join(" ");
}

let buildNameFun: (fname: string, ...rest: string[]) => string = buildName;
```

## this

* 学习如何在 JavaScript 里正确使用 this 就好比一场成年礼。 由于 TypeScript 是 JavaScript 的超集，TypeScript 程序员也需要弄清 this 工作机制并且当有 bug 的时候能够找出错误所在。 幸运的是，TypeScript 能通知你错误地使用了 this 的地方。 如果你想了解 JavaScript 里的 this 是如何工作的，那么首先阅读 Yehuda Katz 写的 Understanding JavaScript Function Invocation and "this"。 Yehuda 的文章详细的阐述了 this 的内部工作原理，因此我们这里只做简单介绍。

## this 和箭头函数

* JavaScript 里，this 的值在函数被调用的时候才会指定。 这是个既强大又灵活的特点，但是你需要花点时间弄清楚函数调用的上下文是什么。 但众所周知，这不是一件很简单的事，尤其是在返回一个函数或将函数当做参数传递的时候。

下面看一个例子：

```typescript
let deck = {
    suits: ["hearts", "spades", "clubs", "diamonds"],
    cards: Array(52),
    createCardPicker: function() {
        return function() {
            let pickedCard = Math.floor(Math.random() * 52);
            let pickedSuit = Math.floor(pickedCard / 13);

            return { suit: this.suits[pickedSuit], card: pickedCard % 13 };
        };
    }
};

let cardPicker = deck.createCardPicker();
let pickedCard = cardPicker();

alert("card: " + pickedCard.card + " of " + pickedCard.suit);
```

* 可以看到 createCardPicker 是个函数，并且它又返回了一个函数。 如果我们尝试运行这个程序，会发现它并没有弹出对话框而是报错了。 因为 createCardPicker 返回的函数里的 this 被设置成了 window 而不是 deck 对象。 因为我们只是独立的调用了 cardPicker()。 顶级的非方法式调用会将 this 视为 window。 （注意：在严格模式下， this 为 undefined 而不是 window）。

* 为了解决这个问题，我们可以在函数被返回时就绑好正确的 this。 这样的话，无论之后怎么使用它，都会引用绑定的‘deck’对象。 我们需要改变函数表达式来使用 ECMAScript 6 箭头语法。 箭头函数能保存函数创建时的 this 值，而不是调用时的值：

```typescript
let deck = {
    suits: ["hearts", "spades", "clubs", "diamonds"],
    cards: Array(52),
    createCardPicker: function() {
        // NOTE: the line below is now an arrow function, allowing us to capture 'this' right here
        return () => {
            let pickedCard = Math.floor(Math.random() * 52);
            let pickedSuit = Math.floor(pickedCard / 13);

            return { suit: this.suits[pickedSuit], card: pickedCard % 13 };
        };
    }
};

let cardPicker = deck.createCardPicker();
let pickedCard = cardPicker();

alert("card: " + pickedCard.card + " of " + pickedCard.suit);
```

* 更好事情是，TypeScript 会警告你犯了一个错误，如果你给编译器设置了--noImplicitThis 标记。 它会指出 this.suits[pickedSuit]里的 this 的类型为 any。

## this 参数

* 不幸的是，this.suits[pickedSuit]的类型依旧为 any。 这是因为 this 来自对象字面量里的函数表达式。 修改的方法是，提供一个显式的 this 参数。 this 参数是个假的参数，它出现在参数列表的最前面：

```typescript
function f(this: void) {
    // make sure `this` is unusable in this standalone function
}
```

* 让我们往例子里添加一些接口，Card 和 Deck，让类型重用能够变得清晰简单些：

```typescript
interface Card {
    suit: string;
    card: number;
}
interface Deck {
    suits: string[];
    cards: number[];
    createCardPicker(this: Deck): () => Card;
}
let deck: Deck = {
    suits: ["hearts", "spades", "clubs", "diamonds"],
    cards: Array(52),
    // NOTE: The function now explicitly specifies that its callee must be of type Deck
    createCardPicker: function(this: Deck) {
        return () => {
            let pickedCard = Math.floor(Math.random() * 52);
            let pickedSuit = Math.floor(pickedCard / 13);

            return { suit: this.suits[pickedSuit], card: pickedCard % 13 };
        };
    }
};

let cardPicker = deck.createCardPicker();
let pickedCard = cardPicker();

alert("card: " + pickedCard.card + " of " + pickedCard.suit);
```

* 现在 TypeScript 知道 createCardPicker 期望在某个 Deck 对象上调用。 也就是说 this 是 Deck 类型的，而非 any，因此--noImplicitThis 不会报错了。

## this 参数在回调函数里

* 你可以也看到过在回调函数里的 this 报错，当你将一个函数传递到某个库函数里稍后会被调用时。 因为当回调被调用的时候，它们会被当成一个普通函数调用， this 将为 undefined。 稍做改动，你就可以通过 this 参数来避免错误。 首先，库函数的作者要指定 this 的类型：

```typescript
interface UIElement {
    addClickListener(onclick: (this: void, e: Event) => void): void;
}
//this: void means that addClickListener expects onclick to be a function that does not require a this type. Second, annotate your calling code with this:

class Handler {
    info: string;
    onClickBad(this: Handler, e: Event) {
        // oops, used this here. using this callback would crash at runtime
        this.info = e.message;
    }
}
let h = new Handler();
uiElement.addClickListener(h.onClickBad); // error!
```

* 指定了 this 类型后，你显式声明 onClickBad 必须在 Handler 的实例上调用。 然后 TypeScript 会检测到 addClickListener 要求函数带有 this: void。 改变 this 类型来修复这个错误：

```typescript
class Handler {
    info: string;
    onClickGood(this: void, e: Event) {
        // can't use this here because it's of type void!
        console.log("clicked!");
    }
}
let h = new Handler();
uiElement.addClickListener(h.onClickGood);
```

* 因为 onClickGood 指定了 this 类型为 void，因此传递 addClickListener 是合法的。 当然了，这也意味着不能使用 this.info. 如果你两者都想要，你不得不使用箭头函数了：

```typescript
class Handler {
    info: string;
    onClickGood = (e: Event) => {
        this.info = e.message;
    };
}
```

这是可行的因为箭头函数不会捕获 this，所以你总是可以把它们传给期望 this: void 的函数。 缺点是每个 Handler 对象都会创建一个箭头函数。 另一方面，方法只会被创建一次，添加到 Handler 的原型链上。 它们在不同 Handler 对象间是共享的。

## 重载

* JavaScript 本身是个动态语言。 JavaScript 里函数根据传入不同的参数而返回不同类型的数据是很常见的。

```typescript
let suits = ["hearts", "spades", "clubs", "diamonds"];

function pickCard(x): any {
    // Check to see if we're working with an object/array
    // if so, they gave us the deck and we'll pick the card
    if (typeof x == "object") {
        let pickedCard = Math.floor(Math.random() * x.length);
        return pickedCard;
    } else if (typeof x == "number") {
        // Otherwise just let them pick the card
        let pickedSuit = Math.floor(x / 13);
        return { suit: suits[pickedSuit], card: x % 13 };
    }
}

let myDeck = [
    { suit: "diamonds", card: 2 },
    { suit: "spades", card: 10 },
    { suit: "hearts", card: 4 }
];
let pickedCard1 = myDeck[pickCard(myDeck)];
alert("card: " + pickedCard1.card + " of " + pickedCard1.suit);

let pickedCard2 = pickCard(15);
alert("card: " + pickedCard2.card + " of " + pickedCard2.suit);
```

* pickCard 方法根据传入参数的不同会返回两种不同的类型。 如果传入的是代表纸牌的对象，函数作用是从中抓一张牌。 如果用户想抓牌，我们告诉他抓到了什么牌。 但是这怎么在类型系统里表示呢。

* 方法是为同一个函数提供多个函数类型定义来进行函数重载。 编译器会根据这个列表去处理函数的调用。 下面我们来重载 pickCard 函数。

```typescript
let suits = ["hearts", "spades", "clubs", "diamonds"];

function pickCard(x: { suit: string; card: number }[]): number;
function pickCard(x: number): { suit: string; card: number };
function pickCard(x): any {
    // Check to see if we're working with an object/array
    // if so, they gave us the deck and we'll pick the card
    if (typeof x == "object") {
        let pickedCard = Math.floor(Math.random() * x.length);
        return pickedCard;
    } else if (typeof x == "number") {
        // Otherwise just let them pick the card
        let pickedSuit = Math.floor(x / 13);
        return { suit: suits[pickedSuit], card: x % 13 };
    }
}

let myDeck = [
    { suit: "diamonds", card: 2 },
    { suit: "spades", card: 10 },
    { suit: "hearts", card: 4 }
];
let pickedCard1 = myDeck[pickCard(myDeck)];
alert("card: " + pickedCard1.card + " of " + pickedCard1.suit);

let pickedCard2 = pickCard(15);
alert("card: " + pickedCard2.card + " of " + pickedCard2.suit);
```

* 这样改变后，重载的 pickCard 函数在调用的时候会进行正确的类型检查。

* 为了让编译器能够选择正确的检查类型，它与 JavaScript 里的处理流程相似。 它查找重载列表，尝试使用第一个重载定义。 如果匹配的话就使用这个。 因此，在定义重载的时候，一定要把最精确的定义放在最前面。

* 注意，`function pickCard(x): any`并不是重载列表的一部分，因此这里只有两个重载：一个是接收对象另一个接收数字。 以其它参数调用 pickCard 会产生错误。

# 泛型

## 介绍

* 软件工程中，我们不仅要创建一致的定义良好的 API，同时也要考虑可重用性。 组件不仅能够支持当前的数据类型，同时也能支持未来的数据类型，这在创建大型系统时为你提供了十分灵活的功能。

* 在像 C#和 Java 这样的语言中，可以使用泛型来创建可重用的组件，一个组件可以支持多种类型的数据。 这样用户就可以以自己的数据类型来使用组件。

## 泛型函数

```typescript
function identity<T>(arg: T): T {
    return arg;
}

let myIdentity: <U>(arg: U) => U = identity;
```

## 泛型接口

```typescript
interface GenericIdentityFn<T> {
    (arg: T): T;
}

function identity<T>(arg: T): T {
    return arg;
}

let myIdentity: GenericIdentityFn<number> = identity;
```

## 泛型类

```typescript
class GenericNumber<T> {
    zeroValue: T;
    add: (x: T, y: T) => T;
}

let myGenericNumber = new GenericNumber<number>();
myGenericNumber.zeroValue = 0;
myGenericNumber.add = function(x, y) {
    return x + y;
};
```

## 泛型约束

```typescript
interface Lengthwise {
    length: number;
}

function loggingIdentity<T extends Lengthwise>(arg: T): T {
    console.log(arg.length); // Now we know it has a .length property, so no more error
    return arg;
}
```

* 高级示例

```typescript
class BeeKeeper {
    hasMask: boolean;
}

class ZooKeeper {
    nametag: string;
}

class Animal {
    numLegs: number;
}

class Bee extends Animal {
    keeper: BeeKeeper;
}

class Lion extends Animal {
    keeper: ZooKeeper;
}

function createInstance<A extends Animal>(c: new () => A): A {
    return new c();
}

createInstance(Lion).keeper.nametag; // typechecks!
createInstance(Bee).keeper.hasMask; // typechecks!
```

# 模块

## 介绍

* 模块是自声明的；两个模块之间的关系是通过在文件级别上使用 imports 和 exports 建立的。

## 导出

### 导出声明

```typescript
export interface StringValidator {
    isAcceptable(s: string): boolean;
}

export const numberRegexp = /^[0-9]+$/;

export class ZipCodeValidator implements StringValidator {
    isAcceptable(s: string) {
        return s.length === 5 && numberRegexp.test(s);
    }
}
```

### 导出语句

* 导出语句很便利，因为我们可能需要对导出的部分重命名，所以上面的例子可以这样改写

```typescript
class ZipCodeValidator implements StringValidator {
    isAcceptable(s: string) {
        return s.length === 5 && numberRegexp.test(s);
    }
}
export { ZipCodeValidator };
export { ZipCodeValidator as mainValidator };
```

### 重新导出

* 我们经常会去扩展其它模块，并且只导出那个模块的部分内容。 重新导出功能并不会在当前模块导入那个模块或定义一个新的局部变量

```typescript
export class ParseIntBasedZipCodeValidator {
    isAcceptable(s: string) {
        return s.length === 5 && parseInt(s).toString() === s;
    }
}

// 导出原先的验证器但做了重命名
export {
    ZipCodeValidator as RegExpBasedZipCodeValidator
} from "./ZipCodeValidator";

export * from "./StringValidator"; // exports interface StringValidator
export * from "./LettersOnlyValidator"; // exports class LettersOnlyValidator
export * from "./ZipCodeValidator"; // exports class ZipCodeValidator
```

## 导入

### 导入一个模块中的某个导出内容

```typescript
import { ZipCodeValidator } from "./ZipCodeValidator";

let myValidator = new ZipCodeValidator();
```

### 将整个模块导入到一个变量，并通过它来访问模块的导出部分

```typescript
import * as validator from "./ZipCodeValidator";
let myValidator = new validator.ZipCodeValidator();
```

## 默认导出

```typescript
export default class ZipCodeValidator {
    static numberRegexp = /^[0-9]+$/;
    isAcceptable(s: string) {
        return s.length === 5 && ZipCodeValidator.numberRegexp.test(s);
    }
}

import validator from "./ZipCodeValidator";

let myValidator = new validator();
```

# 命名空间

## 介绍

* “内部模块”现在叫做“命名空间”，使用 namespace 关键字声明

```typescript
namespace Validation {
    export interface StringValidator {
        isAcceptable(s: string): boolean;
    }

    const lettersRegexp = /^[A-Za-z]+$/;
    const numberRegexp = /^[0-9]+$/;

    export class LettersOnlyValidator implements StringValidator {
        isAcceptable(s: string) {
            return lettersRegexp.test(s);
        }
    }

    export class ZipCodeValidator implements StringValidator {
        isAcceptable(s: string) {
            return s.length === 5 && numberRegexp.test(s);
        }
    }
}

// Some samples to try
let strings = ["Hello", "98052", "101"];

// Validators to use
let validators: { [s: string]: Validation.StringValidator } = {};
validators["ZIP code"] = new Validation.ZipCodeValidator();
validators["Letters only"] = new Validation.LettersOnlyValidator();

// Show whether each string passed each validator
for (let s of strings) {
    for (let name in validators) {
        console.log(
            `"${s}" - ${
                validators[name].isAcceptable(s) ? "matches" : "does not match"
            } ${name}`
        );
    }
}
```

* 相同命名空间可以在多个文件中使用

## 模块

* 对模块使用/// <reference>

```typescript
// In a .d.ts file or .ts file that is not a module:
declare module "SomeModule" {
    export function fn(): string;
}
```

```typescript
/// <reference path="myModules.d.ts" />
import * as m from "SomeModule";
```

* 就像每个 JS 文件对应一个模块一样，TypeScript 里模块文件与生成的 JS 文件也是一一对应的
