http://jsplumb.github.io/jsplumb/home.html#browser


jsPlumb
jsPlumb社区版为开发人员提供了一种使用SVG可视化连接其网页上的元素的方法。

jsPlumb没有外部依赖项。

1.7.x版本是最后一个支持IE8的版本。从2.0.0版开始，社区版仅在支持SVG的现代浏览器中工作。

导入和设置
阅读整个页面是一个好主意。您需要了解有关将jsPlumb与UI集成的一些知识。浏览器兼容性

设定
文件类型
所需进口
初始化jsPlumb
多个jsPlumb实例
方法参数
元素编号
Z索引注意事项
jsPlumb在哪里添加元素？
拖曳
性能

浏览器兼容性
从IE6开始，jsPlumb 1.7.x均可运行。从IE9开始，jsPlumb 2.x均可运行。

文件类型
文字/ HTML
如果您text/html像大多数人一样使用内容类型来提供网页，则应使用此doctype：

<!doctype html>
这使您可以在所有浏览器中使用“标准”模式并访问HTML5。

Required Imports
No required imports.

<script src="PATH_TO/jsplumb.min.js "></script>

初始化jsPlumb
在初始化DOM之前，您不应该开始对jsPlumb进行调用-也许在那里并不奇怪。要处理此问题，您应该绑定到jsPlumb 上的ready事件上（或正在使用的jsPlumb实例）：

jsPlumb.bind("ready", function() {
  ...
  // your jsPlumb related init code goes here
  ...
});
有一种帮助方法可以为您节省一些宝贵的角色：

jsPlumb.ready(function() {
    ...
    // your jsPlumb related init code goes here
    ...
});
如果ready在初始化jsPlumb之后绑定到该事件，则将立即执行回调。

多个jsPlumb实例
jsPlumb默认情况下在浏览器的窗口中注册，为整个页面提供了一个静态实例供使用。您还可以使用getInstance方法实例化jsPlumb的独立实例，例如：

var firstInstance = jsPlumb.getInstance();
变量firstInstance现在可以确切地当作你会认为jsPlumb变量-你可以设置默认值，调用connect方法，无论什么：

firstInstance.importDefaults({
  Connector : [ "Bezier", { curviness: 150 } ],
  Anchors : [ "TopCenter", "BottomCenter" ]
});

firstInstance.connect({
  source:"element1",
  target:"element2",
  scope:"someScope"
});
getInstance （可选）采用提供默认值的对象：

var secondInstance = jsPlumb.getInstance({
  PaintStyle:{
    strokeWidth:6,
    stroke:"#567567",
    outlineStroke:"black",
    outlineWidth:1
  },
  Connector:[ "Bezier", { curviness: 30 } ],
  Endpoint:[ "Dot", { radius:5 } ],
  EndpointStyle : { fill: "#567567"  },
  Anchor : [ 0.5, 0.5, 1, 1 ]
});

secondInstance.connect({
  source:"element4",
  target:"element3",
  scope:"someScope"
});
建议尽可能使用单独的jsPlumb实例。

Element Ids
jsPlumb使用id与其交互的任何元素的属性。如果id未设置，则jsPlumb将为该元素创建一个ID。建议您自己为UI中的元素设置适当的ID。

Changing Element Id
由于jsPlumb使用元素ID，如果jsPlumb元素ID更改。有两种方法可以帮助您执行此操作：

jsPlumb.setId(el, newId)如果您希望jsPlumb负责更改DOM中的ID，请使用此选项。它将这样做，然后相应地更新其引用。

jsPlumb.setIdChanged(oldId, newId) 如果您已经更改了元素的ID，并且只希望jsPlumb更新其引用，请使用此方法。

方法参数
jsPlumb中几乎每个对元素进行操作的方法都支持多种格式来指定要在其上进行操作的元素。

NodeLists/Selectors

在jsPlumb文档中，您将看到对的概念的引用selector。这是与某些CSS规范匹配的元素的列表。在现代浏览器中，您可以通过以下方式获得其中之一：

 someElement.querySelectorAll('.someSelector')
querySelectorAll返回的本机元素是NodeList。

尽管jsPlumb不依赖jQuery，但它也支持jQuery选择器作为元素的参数（因为jQuery的选择器对象类似于列表，即它具有length属性和索引访问器）。因此，如果您恰巧在页面中使用jQuery，这也将起作用：

$(someElement).find(".someSelector")

Element Ids
传递单个字符串作为参数将导致jsPlumb将该字符串视为元素ID。
Element
您可以将DOM元素作为参数传递。这可能不会令您感到惊讶。
Arrays
您还可以传递我们刚刚列出的所有类型的数组。数组的内容可以混合-它们不必全部是一种类型。
Z-index Considerations
使用jsPlumb时，您需要注意UI各个部分的z索引，尤其要确保jsPlumb添加到DOM的元素不会覆盖接口的其他部分。

jsPlumb为每个端点，连接器和叠加层向DOM添加一个元素。因此，对于在每个端点具有可见端点且在中间具有标签的Connection，jsPlumb向DOM添加了四个元素。

为了帮助您正确组织z索引，jsPlumb向其添加的每种元素类型添加了一个CSS类。它们如下：
Component	Class
Endpoint	jtk-端点
Connector	jtk-连接器
Overlay	jtk-覆盖
此外，每当鼠标悬停在端点或连接上时，就会为该组件分配class jtk-hover。有关使用CSS样式化jsPlumb的更多信息，请参阅本页。
重要的是要了解jsPlumb将在DOM中的何处添加其创建的任何元素。如果要使用TL; DR版本，则可以归结为以下内容：

强烈建议您在plumbing开始之前先设置一个Container。
Container是jsPlumb将用作添加到UI的所有人工制品的父元素。通常，将其设为要连接节点的父元素。
如果未指定Container，则jsPlumb会推断Container应该是offsetParent您调用的第一个元素的addEndpoint，makeSource或makeTarget，或者offsetParent是第一次connect调用中的source元素的-以先发生的为准。

早期版本的jsPlumb将所有内容添加到body元素中。就支持哪些元件可以连接而言，这具有最灵活的布置的优点，但是在某些使用情况下会产生意想不到的结果。

考虑一下选项卡中有一些连接的元素的安排：您希望jsPlumb在选项卡中添加元素，以便当用户切换选项卡并且当前选项卡被隐藏时，所有jsPlumb的内容也被隐藏。但是，当元素在身体上时，这不会发生！
在页面中使用jsPlumb的情况也很常见，在该页面中，图表包含在某些元素中，当其内容溢出时，该元素应显示滚动条。将元素追加到文档主体可防止这种情况自动发生。

Container

您可以-并且应该 -指示jsPlumb使用某个元素作为jsPlumb通过使用setContainerjsPlumb 中的方法或在jsPlumb.getInstance 调用的参数中提供Container来添加到UI的所有内容的父项。
重要说明：这是对1.6.2之前的jsPlumb版本的更改。在1.6.2之前的版本中，您可以直接通过jsPlumb.Defaults.Container属性分配容器。您仍然可以执行此操作-我们当然在这里使用Javascript，这是免费的-但它将被忽略。
同样重要如果您碰巧正在使用jsPlumb的draggable方法来使UI的其他部分可拖动（即，不仅是您正在拖动的东西），请注意不要调用draggable充当Container当前实例的元素 ，或者您会在拖动时看到一些奇怪的情况。建议您最好使用jsPlumb启用对非垂直元素的拖动，这是创建一个新实例：

var nonPlumbing = jsPlumb.getInstance();
nonPlumbing.draggable("some element");

Some examples
设置一个容器以用作默认容器：
jsPlumb.setContainer(document.getElementById("foo"));
...
jsPlumb.addEndpoint(someDiv, { endpoint options });

使用元素ID将一个容器设置为用作默认容器，然后连接两个元素。在此示例中创建的元素将是ID为“ containerId”的元素的子元素：
jsPlumb.setContainer("containerId");
...
jsPlumb.connect({ source:someDiv, target:someOtherDiv });

获取一个新的jsPlumb实例，并指定要在构造函数params中使用的容器：
var j = jsPlumb.getInstance({
  Container:"foo"
});
...
jsPlumb.addEndpoint(someDiv, { endpoint:options });

Container CSS

您选择的容器应该已经position:relative设置了，因为它是jsPlumb将用来计算添加到DOM的工件的位置的元素的起源，并且jsPlumb使用绝对定位。

Element Dragging
使用jsPlumb的接口的共同特点是元素是可拖动的。您应该使用jsPlumbInstance.draggable此配置：

myInstanceOfJsPlumb.draggable("elementId");
...因为如果您不这样做，jsPlumb不会知道某个元素已被拖动，并且它也不会重新绘制该元素。

此页面上详细介绍了拖动。
Performance性能
jsPlumb的执行速度以及对可管理连接数的实际限制，在很大程度上取决于运行该浏览器的浏览器。在撰写本文时，得知jsPlumb在Chrome中运行最快，其次是Safari / Firefox，然后是IE浏览器（版本号降序），这可能并不会让您感到惊讶。


Suspending Drawing最后处理画图
通常，jsPlumb中的每个connector addEndpoint调用都会导致关联元素的重新绘制，这在很多情况下是您想要的。但是，如果要执行某种“批量”操作（例如，可能在页面加载时加载数据），建议您在执行操作之前先暂停绘图：

jsPlumb.setSuspendDrawing(true);
...
- load up all your data here -
...
jsPlumb.setSuspendDrawing(false, true);
注意最后一次调用的第二个参数setSuspendDrawing：它指示jsPlumb立即执行完整的重绘（通过内部调用repaintEverything）。

我在上面说过，建议您这样做。真的是 当您在较慢的浏览器上处理大量Connections时，这对加载时间有巨大的影响。

batch批量
此函数抽象出挂起图形，执行某些操作然后重新启用图形的模式：

jsPlumb.batch(fn, [doNotRepaintAfterwards]);

用法示例：

jsPlumb.batch(function() {
  // import here
  for (var i = 0, j = connections.length; i < j; i++) {
      jsPlumb.connect(connections[i]);
  }
});
在这里，我们假定这connections是一个适合传递给该connect方法的对象数组，例如：

{ source:"someElement", target:"someOtherElement" }
默认情况下，这将在最后运行重新绘制。但是，如果您想：

jsPlumb.batch(function() {
  // import here
}, true);
请注意，此方法曾经被调用doWhileSuspended，并在1.7.3版中被重命名。
Anchor Types锚类型
连续锚是需要最多数学知识的类型，因为每次绘制周期都必须计算其位置。

动态锚和外围锚是第二慢的（外围比大多数动态锚慢，因为它们实际上是动态锚，默认情况下有60个位置可供选择）。

静态锚（例如Top）Bottom是最快的。

Zooming缩放
对于使用jsPlumb的各种应用程序，一个相当普遍的要求是能够放大和缩小。从1.5.0版开始，有一种方法可以对支持CSS3的浏览器执行此操作（实质上意味着除IE <9以外的所有内容）。

更改缩放要求您做两件事：

transform在适当的容器上设置属性
告诉jsPlumb缩放级别是多少。

Container容器
您需要确定所有节点和jsPlumb工件的父级元素。这可能是相当明显的。但是，您可能不知道的是ContainerjsPlumb中的概念。如果不这样做，我建议您快速阅读此页面，因为最好的方法是正确配置a Container，然后操纵该transform元素的属性。

假设我们有一些divID为drawing，我们将其用作Container：

jsPlumb.setContainer("drawing");

CSS transform属性
现在将缩放比例设置为0.75，例如，我们相应地更改transform属性。请记住，这transform是具有多个供应商前缀版本的那些属性之一，因此有多种方法可以完成此处的操作，并且鉴于您可能是计算机程序员，因此您很可能会很喜欢。但是无论如何，这里有些东西。

$("#drawing").css({
  "-webkit-transform":"scale(0.75)",
  "-moz-transform":"scale(0.75)",
  "-ms-transform":"scale(0.75)",
  "-o-transform":"scale(0.75)",
  "transform":"scale(0.75)"
});

jsPlumb.setZoom
现在，您需要告诉jsPlumb新的缩放级别：

jsPlumb.setZoom(0.75);

辅助功能
也许您只想抓住这个：
window.setZoom = function(zoom, instance, transformOrigin, el) {
  transformOrigin = transformOrigin || [ 0.5, 0.5 ];
  instance = instance || jsPlumb;
  el = el || instance.getContainer();
  var p = [ "webkit", "moz", "ms", "o" ],
      s = "scale(" + zoom + ")",
      oString = (transformOrigin[0] * 100) + "% " + (transformOrigin[1] * 100) + "%";

  for (var i = 0; i < p.length; i++) {
    el.style[p[i] + "Transform"] = s;
    el.style[p[i] + "TransformOrigin"] = oString;
  }

  el.style["transform"] = s;
  el.style["transformOrigin"] = oString;

  instance.setZoom(zoom);
};
笔记

el是DOM元素。你不必通过el; 如果不这样做，它将使用jsPlumb实例中的Container。
transformOrigin是可选的；它默认为[0.5，0.5]-元素的中间（这也是浏览器的默认值）
instance是jsPlumb的实例-是jsPlumb静态实例，还是您通过获得的某个实例 jsPlumb.newInstance(...)。如果您不提供该功能，则该功能默认为使用jsPlumb的静态实例。
zoom 是小数点，其中1表示100％。

配置默认值Configuring Defaults
设置管道外观的最简单方法是覆盖jsPlumb使用的默认值。如果不这样做，则必须在每次调用时提供覆盖的值。connect和addEndpoint方法的每个参数在jsPlumb中都有一个关联的默认值。

jsPlumb附带的默认值存储在jsPlumb.Defaults，这是一个Javascript对象。有效条目及其初始值是：
Anchor : "BottomCenter",
Anchors : [ null, null ],
ConnectionsDetachable   : true,
ConnectionOverlays  : [],
Connector : "Bezier",
Container : null,
DoNotThrowErrors  : false,
DragOptions : { },
DropOptions : { },
Endpoint : "Dot",
Endpoints : [ null, null ],
EndpointOverlays : [ ],
EndpointStyle : { fill : "#456" },
EndpointStyles : [ null, null ],
EndpointHoverStyle : null,
EndpointHoverStyles : [ null, null ],
HoverPaintStyle : null,
LabelStyle : { color : "black" },
LogEnabled : false,
Overlays : [ ],
MaxConnections : 1,
PaintStyle : { strokeWidth : 8, stroke : "#456" },
ReattachConnections : false,
RenderMode : "svg",
Scope : "jsPlumb_DefaultScope"

请注意，在中EndpointHoverStyle，默认fill值为null。这指示jsPlumb使用stroke附加的连接器的悬停样式中的填充端点。

还要注意的是，你可以指定一个或两个（或没有）的EndpointStyle和EndpointStyles。这使您可以为连接中的每个端点指定不同的样式。 Endpoint并Endpoints使用相同的概念。jsPlumb将首先在单个Endpoint/ EndpointStyle数组中查找，然后回落到单个默认版本。

您可以使用以下importDefaults方法覆盖这些默认值：

jsPlumb.importDefaults({
  PaintStyle : { //连接器为13像素宽，并涂有半透明的红线
    strokeWidth:13,
    stroke: 'rgba(200,0,0,0.5)'
  },
  DragOptions : { cursor: "crosshair" }, //拖动元素时，使用十字光标
  Endpoints : [ [ "Dot", { radius:7 } ], [ "Dot", { radius:11 } ] ], //源端点是半径为7的点；目标端点是半径11的点
  EndpointStyles : [{ fill:"#225588" }, { fill:"#558822" }] //源端点为蓝色；目标端点为绿色
});

每个默认设置的说明

Anchor - 将用作未声明锚的任何端点的锚-这适用于任何连接的源和/或目标。
anchor: ['Bottom', 'Bottom'],

Anchors - 连接的默认源和目标

Connector - 要使用的默认连接器.

ConnectionsDetachable - -默认情况下，使用鼠标是否可分离连接.

Container - 用作jsPlumb添加的所有人工制品的父元素的元素。您无法使用设置此功能importDefaults-只有在您将其作为默认值提供给您传递给getInstance通话时，才能使用它。要在实例化jsPlumb实例后更改容器，请使用setContainer。有关容器概念的讨论，请参见此处。

DoNotThrowErrors - 如果请求不存在的Anchor，Endpoint或Connector，则jsPlumb是否实际上会引发异常.

ConnectionOverlays - 附加到每个Connection的默认叠加层

DragOptions -用于配置任何可拖动元素的默认选项jsPlumb.draggable

DropOptions - 用于配置任何目标端点的可放置行为的默认选项。

Endpoint - The default Endpoint definition. Will be used whenever an Endpoint is added or otherwise created and jsPlumb has not been given any explicit Endpoint definition.
默认端点定义。每当添加或以其他方式创建端点并且未给jsPlumb任何显式端点定义时将使用。

Endpoints - Default source and target Endpoint definitions for use with jsPlumb.connect.
与一起使用的默认源和目标端点定义jsPlumb.connect。

EndpointOverlays - Default Overlays to attach to every Endpoint.
附加到每个端点的默认叠加层

EndpointStyle - Default appearance of an Endpoint.
端点的默认外观。

EndpointStyles - Default appearance of the source and target Endpoints in a Connection
连接中源端点和目标端点的默认外观

EndpointHoverStyle - Default appearance of an Endpoint in hover state.
处于悬停状态的端点的默认外观

EndpointHoverStyles - Default appearance of the source and target Endpoints in a Connection in hover state.
处于悬停状态的Connection中源端点和目标端点的默认外观。

HoverPaintStyle - Default appearance of a Connection in hover state.
处于悬停状态的Connection的默认外观。

LabelStyle - Default style for a Label. Deprecated: use CSS for this instead.
标签的默认样式。不推荐使用：为此，请使用CSS。

LogEnabled - Whether or not jsPlumb's internal logging is switched on.
 -jsPlumb的内部日志记录是否已打开。

Overlays - Default Overlays to add to both Connections and Endpoints
要添加到连接和端点的默认叠加层

MaxConnections - The default maximum number of Connections any given Endpoint supports.
任何给定端点支持的默认最大连接数

PaintStyle - The default appearance of a Connector
连接器的默认外观

ReattachConnections - Whether or not to reattach Connections that were detached using the mouse and then neither reconnected to their original Endpoint nor connected to some other Endpoint.
是否重新附加使用鼠标分离的连接，然后既不重新连接到其原始端点又未连接到某个其他端点。

RenderMode - The default render mode.
默认渲染模式。

Scope - The default scope of Endpoints and Connections. Scope provides a rudimentary control over which Endpoints can be connected to which other Endpoints.
端点和连接的默认范围。范围提供了一个基本控制，可以控制哪些端点可以连接到其他端点

提供jsPlumb.getInstance的默认值
When you create a new instance of jsPlumb via jsPlumb.getInstance you can provide defaults for that instance as a constructor parameter - here's how we'd create a new instance using the same default values as the example above:
当您通过jsPlumb.getInstance创建新的jsPlumb实例时，可以为该实例提供默认值作为构造函数参数-这是我们如何使用与上述示例相同的默认值来创建新实例：

jsPlumb.getInstance({
  PaintStyle : {
    strokeWidth:13,
    stroke: 'rgba(200,0,0,100)'
  },
  DragOptions : { cursor: "crosshair" },
  Endpoints : [ [ "Dot", { radius:7 } ], [ "Dot", { radius:11 } ] ],
  EndpointStyles : [
    { fill:"#225588" },
    { fill:"#558822" }
  ]
});

Basic Concepts
Introduction
Connector, Endpoint, Anchor & Overlay Definitions

介绍
jsPlumb就是将事物连接在一起，因此jsPlumb的核心抽象是Connection对象，它本身分为以下五个概念：

Anchor  -相对于元素原点的位置，可以存在端点。您不是自己创建这些文件的；而是您自己创建的。您可以向各种jsPlumb函数提供提示，这些提示可以根据需要创建。他们没有视觉表现；它们只是逻辑位置。jsPlumb附带的Anchors或包含各种参数的数组可以通过名称来引用Anchors，以实现更好的控制。有关更多详细信息，请参见锚点页面。

Endpoint -连接一端的视觉表示。您可以自己创建这些元素并将其附加到元素上，以支持拖放操作，或者使用来以编程方式创建Connection时让jsPlumb创建它们jsPlumb.connect(...)。您还可以通过编程将两个端点作为参数传递给，从而将它们连接起来jsPlumb.connect(...)。有关更多详细信息，请参见“ 端点”页面。

Connector -连接页面中两个元素的线的直观表示。jsPlumb有四种默认类型可用：贝塞尔曲线，直线，“流程图”连接器和“状态机”连接器。您不与连接器交互；您只需要在需要时指定它们的定义。有关更多详细信息，请参见 连接器页面。

Overlay -用于装饰连接器的UI组件，例如标签，箭头等。

Group -包含在某些其他元素中的一组元素，这些元素可以折叠，导致与所有Group成员的连接被合并到折叠的Group容器中。有关更多信息，请参见“ 组” 页面。

一个连接由两个端点，一个连接器以及零个或多个叠加层共同组成两个元素组成。每个端点都有一个关联的锚。

jsPlumb的公共API仅公开Connection和Endpoint，在内部处理其他所有内容的创建和配置。但是您仍然需要了解由Anchor，Connector和Overlay封装的概念。

Connector, Endpoint, Anchor & Overlay Definitions
每当需要定义连接器，端点，锚或覆盖时，都必须使用它的“定义”，而不是直接构造一个。此定义可以是指定您要创建的工件的字符串，请参见endpoint此处的参数：

jsPlumb.connect({
    source:"someDiv",
    target:"someOtherDiv",
    endpoint:"Rectangle"
});
...或包含工件名称和要传递给其构造函数的参数的数组：

jsPlumb.connect({
    source:"someDiv",
    target:"someOtherDiv",
    endpoint:[ "Rectangle", {
      cssClass:"myEndpoint",
      width:30,
      height:10
  }]
});

还有三个参数方法，可让您指定两组参数，jsPlumb将为您合并这些参数。其背后的想法是，您通常会希望在某处定义通用特征，并在许多不同的调用中重用它们：

var common = {
    cssClass    :   "myCssClass",
    hoverClass  :   "myHoverClass"
};
jsPlumb.connect({
    source:"someDiv",
    target:"someOtherDiv",
    endpoint:[ "Rectangle", { width:30, height:10 }, common ]
});

所有端点，连接器，锚和覆盖定义均支持此语法。这是使用所有四个定义的示例：

var common = {
    cssClass:"myCssClass"
};
jsPlumb.connect({
  source:"someDiv",
  target:"someOtherDiv",
  anchor:[ "Continuous", { faces:["top","bottom"] }],
  endpoint:[ "Dot", { radius:5, hoverClass:"myEndpointHover" }, common ],
  connector:[ "Bezier", { curviness:100 }, common ],
  overlays: [
        [ "Arrow", { foldback:0.2 }, common ],
        [ "Label", { cssClass:"labelClass" } ]
    ]
});
对于您创建的每个工件，允许的构造函数参数都是不同的，但是每个工件都将单个JS对象作为参数，而该对象中的参数是（（键，值）对）。

Anchors

Introduction

一个Anchor模型Connector定义了一个元素应该在哪里连接的概念-它定义了一个元素的位置Endpoint。锚有四种主要类型：

Static - 固定在元素上的某个点并且不会移动。可以使用字符串来指定它们，以标识jsPlumb附带的默认值之一，或者使用描述位置的数组

jsPlumb具有九个默认锚点位置，可用于指定连接器连接到元素的位置：这些是元素的四个角，元素的中心以及元素的每个边缘的中点：

Top（也别名为TopCenter）
TopRight
Right（也别名为RightMiddle）
BottomRight
Bottom（也别名为BottomCenter）
BottomLeft
Left（也别名为LeftMiddle）
TopLeft
Center
这些字符串表示中的每一个都只是围绕基于数组的基础语法的包装 [x, y, dx, dy]，其中x和y是间隔中的坐标，[0,1]用于指定锚点的位置，并且dx和和dy（用于指定入射到锚点的曲线的方向）可以具有一个值0、1或-1。例如，[0, 0.5, -1, 0]定义一个Left锚，该锚具有从锚向左发出的连接器曲线。类似地，[0.5, 0, 0, -1]定义一个Top锚，其连接器曲线向上散发。

jsPlumb.connect({...., anchor:"Bottom", ... });
等同于：

jsPlumb.connect({...., anchor:[ 0.5, 1, 0, 1 ], ... });
锚点偏移
除了提供锚点的位置和方向之外，您还可以选择提供另外两个参数，这些参数定义距给定位置的像素偏移量。这是上面指定的锚点，但在y轴元素下方偏移了50个像素：

jsPlumb.connect({...., anchor:[ 0.5, 1, 0, 1, 0, 50 ], ... });

Dynamic - 这些是静态锚的列表，每次绘制Connection时，jsPlumb都会从中选择最合适的锚。用于确定最合适的锚点的算法会选择最接近Connection中另一个元素中心的锚点。将来的jsPlumb版本可能支持可插拔算法来做出此决定。.

这些锚可以放置在多个位置之一中，每次在UI中移动或绘制物体时都选择最合适的一个。

创建动态锚没有特殊的语法。您只提供了一系列单独的静态锚规范，例如：

var dynamicAnchors = [ [ 0.2, 0, 0, -1 ],  [ 1, 0.2, 1, 0 ],
               [ 0.8, 1, 0, 1 ], [ 0, 0.8, -1, 0 ] ];

jsPlumb.connect({...., anchor:dynamicAnchors, ... });
请注意，您可以混合使用以下各个静态锚规范的类型：

var dynamicAnchors = [ [ 0.2, 0, 0, -1 ],  [ 1, 0.2, 1, 0 ],
               "Top", "Bottom" ];

jsPlumb.connect({...., anchor:dynamicAnchors, ... });

默认动态锚
jsPlumb提供了一种称为动态锚AutoDefault从选Top，Right，Bottom和Left：

jsPlumb.connect({...., anchor:"AutoDefault", ... });

位置选择
决定选择哪个位置的算法只是计算哪个位置最接近Connection中另一个元素的中心。如果需要，将来的jsPlumb版本可能会支持更复杂的选择算法。

可拖动的连接
动态锚和可拖动连接可以互操作：当您开始从动态锚中拖动连接时，jsPlumb会锁定动态锚的位置，并在建立或放弃连接后将其解锁。到那时，您可能会看到动态锚点更改的位置，因为jsPlumb优化了连接。

您可以在可拖动的连接演示中看到此行为，当您将连接从窗口1的蓝色端点拖到窗口3的蓝色端点时-建立连接，然后窗口1的蓝色端点向下跳到一个更接近的位置视窗3。

Perimeter anchors - 这些锚点遵循某些给定形状的周边。本质上讲，它们是动态锚，其位置是从基础形状的周长中选择的。
这些是动态锚的一种形式，其中锚的位置是从某些给定形状的周边中选择的。jsPlumb支持六种形状：

Circle
Ellipse
Triangle
Diamond
Rectangle
Square
Rectangle从Square严格意义上讲，和并不是必须的，因为矩形是Web页面中的标准格式。但是为了完整起见，将它们包括在内。

jsPlumb.addEndpoint("someElement", {
  endpoint:"Dot",
  anchor:[ "Perimeter", { shape:"Circle" } ]
});
在此示例中，我们的锚点将绕着圆所刻画的路径行进，圆的直径是基础元素的宽度和高度。

请注意，Circle形状因此与相同Ellipse，因为假定基础元素的宽度和高度相等，如果不相同，则将得到一个椭圆形。Rectangle并Square有相同的关系。

默认情况下，jsPlumb使用60个锚点位置估算周长。不过，您可以更改此设置：

jsPlumb.addEndpoint("someDiv", {
    endpoint:"Dot",
    anchor:[ "Perimeter", { shape:"Square", anchorCount:150 }]
});
显然，点数越多，操作越流畅。而且浏览器还需要做更多的工作。

这是一个三角形和菱形示例，仅出于完整性考虑：

jsPlumb.connect({
    source:"someDiv",
    target:"someOtherDiv",
    endpoint:"Dot",
    anchors:[
        [ "Perimeter", { shape:"Triangle" } ],
        [ "Perimeter", { shape:"Diamond" } ]
    ]
});
您可以rotation为Perimeter锚提供一个值-在本演示中可以看到一个示例。使用方法如下：

jsPlumb.connect({
    source:"someDiv",
    target:"someOtherDiv",
    endpoint:"Dot",
    anchors:[
        [ "Perimeter", { shape:"Triangle", rotation:25 } ],
        [ "Perimeter", { shape:"Triangle", rotation:-335 } ]
    ]
});
请注意，该值必须以度为单位，而不是以弧度为单位，并且该值可以是正数或负数。在上面的示例中，两个三角形当然旋转了相同的量。

Continuous anchors - 这些锚不固定在任何特定位置；根据元素相对于关联Connection中另一个元素的方向，将它们分配给元素的四个面之一。与静态或动态锚相比，连续锚的计算强度稍高，因为需要jsPlumb来计算绘制周期内每个Connection的位置，而不是仅属于运动元素的Connection。如上所述，这些是锚，其位置由jsPlumb根据Connection中元素之间的方向以及还有多少其他的Continuous锚碰巧共享该元素来计算。您可以使用要用来指定默认静态锚点之一的字符串语法来指定要使用连续锚点，例如：

jsPlumb.connect({
    source:someDiv,
    target:someOtherDiv,
    anchor:"Continuous"
});
请注意，在此示例中，我仅指定了“ anchor”，而不是“ anchors”-jsPlumb将对两个锚使用相同的规范。但是我可以这样说：

jsPlumb.connect({
  source:someDiv,
  target:someOtherDiv,
  anchors:["Bottom", "Continuous"]
});
...这会导致源元素在处具有静态锚点BottomCenter。但实际上，如果Connection中的两个元素都使用连续锚，则似乎连续锚最有效。

另请注意，可以在addEndpoint呼叫中指定连续锚：

jsPlumb.addEndpoint(someDiv, {
  anchor:"Continuous",
  paintStyle:{ fill:"red" }
});
...在makeSource/ makeTarget：

jsPlumb.makeSource(someDiv, {
  anchor:"Continuous",
  paintStyle:{ fill:"red" }
});

jsPlumb.makeTarget(someDiv, {
  anchor:"Continuous",
  paintStyle:{ fill:"red" }
});
...，并且在jsPlumb默认值中：

jsPlumb.Defaults.Anchor = "Continuous";

连续锚面
默认情况下，连续锚将从其所在元素的所有四个面上选择点。不过，您可以使用faces锚点规范中的参数来控制此行为：

jsPlumb.makeSource(someDiv, {
    anchor:["Continuous", { faces:[ "top", "left" ] } ]
});
允许的值是：top - left - right - -bottom

如果为faces参数提供一个空数组，则jsPlumb将默认使用所有四个面。


将CSS类与锚关联
上面讨论的数组语法支持可选的第7个值，该值是代表CSS类的字符串。然后，将此CSS类与锚点关联，并在选定锚点时将其应用于锚点的端点和元素。

当然，始终会“选择”静态锚，但动态锚会在许多不同的位置循环，并且每个锚都可能具有与之关联的不同CSS类。

写入Endpoint和Element的CSS类以相关的jsPlumb实例的endpointAnchorClass前缀为前缀，默认为：

jtk-endpoint-anchor-
因此，例如，如果您具有以下条件：

var ep = jsPlumb.addEndpoint("someDiv", {
  anchor:[0.5, 0, 0, -1, 0, 0, "top" ]
};
然后，由jsPlumb创建的Endpoint以及元素someDiv将为其分配了此类：

jtk-endpoint-anchor-top
使用动态锚点的示例：

var ep = jsPlumb.addEndpoint("someDiv", {
  anchor:[
    [ 0.5, 0, 0, -1, 0, 0, "top" ],
    [ 1, 0.5, 1, 0, 0, 0, "right" ]
    [ 0.5, 1, 0, 1, 0, 0, "bottom" ]
    [ 0, 0.5, -1, 0, 0, 0, "left" ]
  ]
});
在这里，当锚点位置更改时，分配给Endpoint和Element的类将在这些值之间循环：

jtk-endpoint-anchor-top
jtk-endpoint-anchor-right
jtk-endpoint-anchor-left
jtk-endpoint-anchor-bottom
请注意，如果您提供的类名称包含多个术语，则jsPlumb不会在该类中的每个术语之前添加前缀：

var ep = jsPlumb.addEndpoint("someDiv", {
  anchor:[ 0.5, 0, 0, -1, 0, 0, "foo bar" ]
});
将导致将2个类添加到Endpoint和Element：

jtk-endpoint-anchor-foo
和

bar

Changing the anchor class prefix
更改锚类前缀
与锚点类一起使用的前缀存储为jsPlumb成员endpointAnchorClass。您可以在jsPlumb的某些实例上将其更改为任意值：

jsPlumb.endpointAnchorClass = "anchor_";
或许

var jp = jsPlumb.getInstance();
jp.endpointAnchorClass = "anchor_";


Static Anchors
Dynamic Anchors
Default Dynamic Anchor
Location Selection
Perimeter Anchors
Perimeter Anchor Rotation
Continuous Anchors
Continuous Anchor Faces
Associating CSS classes with Anchors

Connectors

连接器是实际上连接UI元素的线。jsPlumb具有四个连接器实现-直线，贝塞尔曲线，“流程图”和“状态机”。默认连接器是贝塞尔曲线。

您可选择通过设置指定接口connector上的呼叫属性jsPlumb.connect， jsPlumb.addEndpoint(s)，jsPlumb.makeSource或jsPlumb.makeTarget。如果您未提供的值connector，则将使用默认值。
您可以使用连接器，端点，锚点和覆盖定义中描述的语法指定连接器 。每种连接器类型允许的构造函数值如下所述。
Bezier 曲线在两个端点之间提供三次贝塞尔曲线路径。它支持一个构造函数参数：

curviness -可选的; 默认值为150。这定义了Bezier控制点到锚点的距离（以像素为单位）。这并不意味着您的连接器将通过与曲线相距此距离的点。这暗示了您希望曲线如何移动。与其在这里没有详细讨论贝塞尔曲线，我们不如将您引至Wikipedia。

Straight 在两个端点之间绘制一条直线。支持两个构造函数参数：

stub -可选，默认为0。此参数的任何正值将导致该长度的存根从直线段连接到连接的另一端之前的端点发出。
gap -可选，默认为0。端点与存根的起点或连接到另一个端点的段之间的间隔。

Flowchart 绘制由一系列垂直或水平段组成的连接-经典流程图外观。支持四个构造函数参数：

stub - 这是从端点发出的初始存根的最小长度（以像素为单位）。这是一个可选参数，可以是一个整数，该整数指定连接器两端的存根，也可以是两个整数的数组，指定连接中[源，目标]端点的存根。默认值为30像素的整数。
alwaysRespectStubs - 可选，默认为false。此参数指示jsPlumb始终在每个端点之外绘制指定桩号长度的线，而不是在两个元素比两个桩号之和更近的情况下自动减少桩号。

gap -可选，默认为0像素。使您可以指定连接器的末端与其连接的元素之间的间隙。
midpoint - 可选，默认为0.5。这是将绘制流程图连接器最长部分的两个元素之间的距离。此参数在您具有以图形方式控制图形并且可能希望避免页面上其他元素的情况下很有用。
cornerRadius  默认值为0。此参数为正值将导致弯曲的角段。

此连接器支持在同一元素上开始和结束的连接（“环回”连接）。

State Machine 绘制略微弯曲的线（它们实际上是二次贝塞尔曲线），类似于您在GraphViz等软件中可能看到的状态机连接器。这些连接器支持某些元素既是源又是目标（“环回”）的连接（与流程图连接器一样）；在这种情况下，您会得到一个圆圈。支持的构造函数参数为：

margin- 可选的; 默认值为5。定义到连接器开始/结束的元素的距离。
curviness -可选，默认为10。这与贝塞尔曲线上的曲线参数具有相似的效果。
proximityLimit -可选，默认为80。在将连接器自身绘制为直线而不是二次贝塞尔曲线之前，连接器两端之间的最小距离。




Groups

jsPlumb支持“组”的概念，“组”是充当一组子元素的父元素的元素。拖动Group元素时，其子元素（在DOM中为Group元素的子节点）也将与其一起拖动。组可能会折叠，这会导致其所有子元素都被隐藏，并且从子元素到Group外部的任何连接都将被“代理”到Group的折叠元素上。

Adding a Group

要添加组，您首先需要将其添加为DOM中的元素。假设您有一个名为的元素 foo。它可以是任何有效的HTML元素，但是由于Groups本质上是其他元素的容器，因此最好坚持使用trusty div。因此，假设您有一个foo引用DIV元素的变量。

一个简单的示例，使用默认值：

jsPlumb.addGroup({
  el:"foo",
  id:"aGroup"
});

在这里，我们创建了一个ID为的网上论坛aGroup。其元素-- foo将变为可拖动，并且还将配置为接受放置在其上的元素。默认情况下，子元素将可在Group元素外部拖动，但如果未将其拖放到另一个Group上，它们将恢复到其在Group元素内部的位置，然后再被拖动。

可以配置组行为的多个方面。从广义上讲，它们分为两类：Group元素的行为及其子元素的行为。

组元素参数
draggable默认情况下设置为true。如果为false，则不会将Group元素制成可拖动元素。
dragOptions用于Group元素的拖动行为的选项。您可能需要在中考虑的一个参数dragOptions是filter，它提供一个或多个选择器来标识不应引起拖动开始的元素。对于Group元素，您可能需要标识Group的子元素，以便可以拖动它们而无需开始拖动Group元素。
droppable默认情况下设置为true。如果为false，则Group元素不允许将元素拖放到该元素上以将其添加到Group中。
dropOptions组元素的放置行为的选项。
proxied 默认为true。表示当折​​叠组时，应通过附加到组元素的连接来代理到组内部子元素（从组外部发出）的连接。

Child element behaviour parameters

revert  恢复默认情况下，这是true的，这意味着放到组外（而不是放到另一个接受可放置对象的组上）的子元素将在mouseup上恢复到其在组内的最后位置。如果进行设置，revert:false 则会得到一个Group，该Group允许子元素存在于Group元素的边界之外，但在拖动Group时仍将拖动子元素，而在折叠Group时将使其不可见。

prune 默认情况下设置为false。如果为true，则将从Group和jsPlumb实例中删除掉在Group元素之外的空格中的子元素，并且还将清除连接到该元素的所有连接。

orphan 默认情况下设置为false。如果为true，则将从Group中删除掉在Group元素之外的空格中的子元素，但不会从jsPlumb实例中删除。

constrain 默认情况下设置为false。如果为true，则将子元素限制为仅拖动到Group元素内部。

ghost 默认情况下设置为false。如果为true，则将拖动到Group元素之外的子元素保留其原始元素，并替换一个用鼠标跟踪的'ghost'元素-原始元素的克隆。

dropOverride 默认情况下为False。如果为true，则可以将子元素拖到Group元素之外（假设没有其他标志可以阻止此情况），但是不能将其拖放到其他Groups上

Collapsed state
收合状态

By default, a Group will initially be rendered in its expanded state. You can request the Group be collapsed initially:
默认情况下，组最初将以其展开状态呈现。您可以要求最初折叠组：
jsPlumb.addGroup({
  el:"foo",
  collapsed:true
});

Removing a Group
可以使用以下removeGroup方法删除组：

jsPlumb.removeGroup("aGroup");
这将删除ID为的组aGroup。如果还希望删除Group的所有子元素，则可以提供第二个参数：

jsPlumb.removeGroup("aGroup", true);

Proxy Endpoints
代理端点
您可以控制使用anchor和endpoint参数折叠组时出现的端点的位置，外观和行为。这些值与它们出现在API的其他部分中的值相同。例如，也许您想显示一个较小的圆点，以跟踪Group折叠时的周长：

jsPlumb.addGroup({
    el:someElement,
    id:"aGroup",
    anchor:"Continuous",
    endpoint:[ "Dot", { radius:3 } ]
});
也许您想在左上角显示一个大矩形：

jsPlumb.addGroup({
    el:someElement,
    id:"aGroup",
    anchor:"TopLeft",
    endpoint:[ "Rectangle", { width:10, height:10 } ]
});
等等。任何有效anchor或endpoint可以使用。

Adding an element to a Group
向组添加元素
您可以使用以下addToGroup(group, el)方法以编程方式将元素添加到组中：

jsPlumb.addToGroup("aGroup", someElement);
如果尝试添加已经属于某个其他组的元素，则会引发异常。

Removing an element from a Group
从组中删除元素
您可以使用以下removeGromGroup(el)方法以编程方式从组中删除元素：

jsPlumb.removeFromGroup(someElement);
请注意，您无需指定要从中删除元素的组。由于一个元素一次只能属于一个组，因此只需将其从该组中删除即可。如果使用不属于Group的元素调用此方法，则不会发生任何事情。

Dragging and dropping child elements
拖放子元素
默认情况下，组配置为接受放置到其上的元素-当前由jsPlumb实例管理的任何元素，而不仅仅是其他组的现有成员。有几种方法可以防止这种情况，以上均已讨论过：

创建群组时，将droppable：false设置为：
jsPlumb.addGroup({
    el:someElement,
    droppable:false
});
这样可以防止组接受已删除的元素。

创建组时，设置constrain：true：
jsPlumb.addGroup({
  el:someElement,
  constrain:true
});
这样可以防止将元素拖到组外。

创建组时，设置dropOverride：true：
jsPlumb.addGroup({
  el:someElement,
  dropOverride:true
});
这样可以防止元素掉到其他组上。

Collapsing and expanding Groups
合并和扩大小组
使用collapseGroup和expandGroup：

jsPlumb.collapseGroup("aGroup");

jsPlumb.expandGroup("aGroup");

CSS Classes
jtk-group-expanded	添加到未折叠的组元素（在组初始化时添加）
jtk-group-collapsed	添加到折叠的组元素
jtk-ghost-proxy	添加到当`ghost`设置为true时使用的proxy元素中

Events事件

与组一起使用的各种方法引发了许多事件。

Event	Description	Parameters
group:add 当添加新组时触发	{group:Group}
group:remove	移除组时触发	{group:Group}
group:addMember	当一个元素添加到一个组时。如果提供了“ sourceGroup”，则表明该元素在添加到该组之前曾是该组的成员。 	{group:Group, el:Element, [sourceGroup]:Group}
group:removeMember	从组中删除元素时触发。如果提供了“ targetGroup”，则表示该元素将从该组中删除后将被添加到该组中.	{group:Group, el:Element, [targetGroup]:Group}
group:collapse	群组合拢时触发	{group:Group}
group:expand	展开群组时触发	{group:Group}

Miscellaneous Methods方法
getGroup(ID) 返回具有给定ID的组。可能为空。
getGroupFor（elementOrID） -获取给定元素（指定为DOM元素或元素ID）所属的组。如果元素不存在或不属于Group，则返回null。
getMembers（） -请注意，这是Group对象上的方法，您可以从addGroup对jsPlumb实例的调用中获取 该方法，或者使用来从jsPlumb实例检索getGroup(groupId)。




