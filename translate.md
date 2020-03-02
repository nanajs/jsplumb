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




