<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Document</title>
  <script src="http://code.angularjs.org/1.2.25/angular.min.js"></script>
  <script src="./lib/jsplumb.js"></script>
  <style>
    .appData {
      position: relative;
    }

    .parentType {
      border: 1px solid royalblue;
      clear: both;
      position: absolute;
      width: 222px;
      height: 182px;
    }

    .childrenItem {
      width: 80px;
      height: 30px;
      border: 1px solid rebeccapurple;
      position: absolute;
      min-width: 80px;
      min-height: 30px;
    }

    .childrenItem span {
      display: inline-block;
      width: 100%;
      height: 100%;
    }

    .arrow {
      width: 10px;
      height: 10px;
      border: 1px solid red;
    }
  </style>
</head>

<body>
  <div id="appData" ng-app="appData" ng-controller="GreetingCtrl">
    <div ng-repeat="parentItem in nodeList.groups" style="overflow: scroll;" id="{{parentItem.id}}"
      group="{{parentItem.id}}" class="parentType">
      <div style="width: 100%;line-height:26px;text-align: center;background-color: #ccc;">{{parentItem.id}}</div>

      <div style="position: absolute;width: 60px;height: 30px;" ng-repeat="childGroup in parentItem.childGroup"
        id="{{childGroup[0].id}}">{{childGroup[0].id}}</div>
      <div style="position: absolute;width: 60px;height: 30px;" ng-repeat="childGroup in parentItem.childGroup"
        id="{{childGroup[1].id}}">{{childGroup[1].id}}</div>
    </div>
    <script>
      var myApp = angular.module('appData', []);

      myApp.controller('GreetingCtrl', ['$scope', '$timeout', function ($scope, $timeout) {

        $scope.nodeList = {
          "nodes": [{
              "id": "window1",
              "name": "1",
              "left": 10,
              "top": 20,
              "group": "one"
            },
            {
              "id": "window2",
              "name": "2",
              "left": 140,
              "top": 50,
              "group": "one"
            },
            {
              "id": "window3",
              "name": "3",
              "left": 450,
              "top": 50
            },
            {
              "id": "window4",
              "name": "4",
              "left": 110,
              "top": 370
            },
            {
              "id": "window5",
              "name": "5",
              "left": 140,
              "top": 150,
              "group": "one"
            },
            {
              "id": "window6",
              "name": "6",
              "left": 50,
              "top": 50,
              "group": "two"
            },
            {
              "id": "window7",
              "name": "7",
              "left": 50,
              "top": 450
            },
            {
              "id": "window8",
              "name": "8",
              "left": 50,
              "top": 150,
              "group": "three"
            }
          ],
          "edges": [{ // 连线
              "source": "window1",
              "target": "window3",
              "data": {}
            },
            {
              "source": "window1",
              "target": "window4",
              "data": {}
            },
            {
              "source": "window3",
              "target": "window5",
              "data": {}
            },
            {
              "source": "window4",
              "target": "window6",
              "data": {}
            },
            {
              "source": "window5",
              "target": "window2",
              "data": {}
            },
            {
              "source": "window6",
              "target": "window2",
              "data": {}
            },
            {
              "source": "three",
              "target": "one",
              "data": {}
            }
          ],
          "ports": [],
          "groups": [{ // 都有哪些组
              "id": "one",
              "title": "Group 1",
              "left": 100,
              "top": 50,
              childGroup: [
                [{
                  id: "window1.1"
                }, {
                  id: "window1.2"
                }],
                [{
                  id: "window1.3"
                }, {
                  id: "window1.4"
                }]
              ]
            },
            {
              "id": "two",
              "title": "Group 2",
              "left": 450,
              "top": 250,
              "type": "constrained",
              childGroup: [
                [{
                  id: "window2.1"
                }, {
                  id: "window2.2"
                }],
                [{
                  id: "window2.3"
                }, {
                  id: "window2.4"
                }]
              ]
            },
            {
              "id": "three",
              "title": "Group 3",
              "left": 350,
              "top": 300,
              childGroup: [
                [{
                  id: "window3.1"
                }, {
                  id: "window3.2"
                }],
                [{
                  id: "window3.3"
                }, {
                  id: "window3.4"
                }]
              ]
            }
          ]
        }
        $timeout(function () {
          jsPlumb.ready(function () {

            var j = jsPlumb.getInstance({
              Container: appData, // 容器
              Connector: "StateMachine", //连线方式
              Endpoint: ["Dot", {
                radius: 3
              }],
              Anchor: "Center"
            });
            j.bind("connection", function (p) {
              console.log(p);
              p.connection.bind("click", function () {
                j.detach(this);
              });
            });
            $scope.nodeList.groups.forEach(function (parentItem, parentIndex) {

              j.addGroup({
                el: document.getElementById(parentItem.id),
                id: parentItem.id,
                constrain: true,
                anchor: "Continuous",
                endpoint: "Blank",
                droppable: false
              });
              parentItem.childGroup.forEach(function (childItem,childIndex) {
                childItem.forEach(function (item,index) {
                var eleObj = document.getElementById(item.id);
                  eleObj.style.top = index % 2 === 0 ? 10 : 140 + 'px';
                  eleObj.style.left = childIndex * 90 + 'px'; //每个元素的宽度
                  j.addToGroup(parentItem.id,eleObj);
                  j.draggable(item.id);
                });
                j.connect({
                  source: document.getElementById(childItem[0].id),
                  target: document.getElementById(childItem[1].id)
                });
              })
            });

            jsPlumb.fire("jsPlumbDemoLoaded", j);
            // 绘制


          });

        }, 100);

        /*  jsPlumb.ready(function () {

          var firstInstance = {};
          // 全局样式定义，默认样式 //单个定义使用getInstance
          jsPlumb.importDefaults({
            PaintStyle: { //连接器为13像素宽，并涂有半透明的红线
              strokeWidth: 13,
              stroke: 'rgba(200,0,0,0.5)'
            },
            ReattachConnections: false, //是否重新连接使用鼠标分离的线
            DragOptions: {
              cursor: "crosshair"
            }, //拖动元素时，使用十字光标
            Endpoints: [
              ["Dot", {
                radius: 7
              }],
              ["Dot", {
                radius: 11
              }]
            ], //源端点是半径为7的点；目标端点是半径11的点
            ConnectionsDetachable: false, // 全局不能移动连接线
            EndpointStyles: [{
              fill: "#225588"
            }, {
              fill: "#558822"
            }] //源端点为蓝色；目标端点为绿色
          });
          $scope.nodeList.groups.forEach(function (parentItem, parentIndex) {
            firstInstance[parentItem.id] = jsPlumb.getInstance();
            // 执行操作之前先暂停绘图
            firstInstance[parentItem.id].setSuspendDrawing(true);
            var eleObj = document.getElementById(parentItem.id);
            eleObj.style.top = parentItem.top + 'px';
            eleObj.style.left = parentItem.left + 'px';
            eleObj.style.zIndex = parentIndex;
            firstInstance[parentItem.id].addGroup({
              el: eleObj,
              id: parentItem.id,
              droppable: false, // 是否拖放子元素，子元素是否可以放置其他元素
              anchor: ['Top', 'Bottom'],
              constrain: false, // 防止组接受已删除的元素，子元素仅限在元素内拖动
              dropOverride: true, // 防止将元素拖到组外
              // draggable: true, // 默认为true,组是否可以拖动
              revert: true, // 元素是否可以拖到只有边框可以重合
              endpoint: ["Rectangle", {
                width: 10,
                height: 10
              }]
            });
            firstInstance[parentItem.id].draggable(parentItem.id, {
              containment: true
            });

            parentItem.childGroup.forEach(function (childItem, childIndex) {
              childItem.forEach(function (item, index) {
                var eleObj = document.getElementById(item.id);
                if (eleObj) {
                var eleObj = document.getElementById(item.id);
                  eleObj.style.top = index % 2 === 0 ? 10 : 140 + 'px';
                  eleObj.style.left = childIndex * 90 + 'px'; //每个元素的宽度
                  firstInstance[parentItem.id].addToGroup(item.group, eleObj);
                  firstInstance[parentItem.id].bind("connectionDetached", function (conn,
                    originalEvent) {
                    if (conn.sourceId == conn.targetId) {
                      //自己连接自己时会自动取消连接
                    } else {
                      alert("删除连接从" + conn.sourceId + "到" + conn.targetId + "！");
                    }
                    firstInstance[parentItem.id].setSuspendDrawing(false, true);
                  });
                  firstInstance[parentItem.id].draggable(document.getElementById(parentItem.id), {
                    containment: true
                  });
                }
              });
              firstInstance[parentItem.id].connect({
                source: document.getElementById(childItem[0].id),
                target: document.getElementById(childItem[1].id),
                connector: ['Flowchart'], // 连接线样式
                anchor: ['Bottom', 'Top'], // 连接点的位置
                // endpoint: ["Image", { src: './apidocs/assets/favicon.png' }]
                // endpoints: [
                //   ["Rectangle", {
                //     width: 10,
                //     height: 10,
                //     cssClass: "arrow"
                //   }],
                //   ["Dot", {
                //     radius: 11
                //   }]
                // ], //源端点是半径为7的点；目标端点是半径11的点
                // endpointStyles: [{
                //   fill: "#225588"
                // }, {
                //   fill: "#558822"
                // }], //源端点为蓝色；目标端点为绿色
                overlays: [
                  "Arrow",
                  ["Label", {
                    label: "foo",
                    location: 100,
                    id: "myLabel"
                  }]
                ],
                // connectorOverlays: [
                //   ["Arrow", {
                //     width: 10,
                //     length: 30,
                //     location: 1,
                //     id: "arrow"
                //   }],
                //   ["Label", {
                //     label: "foo",
                //     id: "label"
                //   }]
                // ],
              });
              firstInstance[parentItem.id].setSuspendDrawing(false, true);
            });
          });

          // 绘制


        });
 */
      }]);
    </script>

</body>

</html>
