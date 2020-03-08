<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Document</title>
  <style>
    * {
      padding: 0;
      margin: 0;
    }

    .title {
      width: 100%;
      line-height: 28px;
      background-color: aqua;
    }

    .topo_group {
      height: 200px;
      position: absolute;
      border: 1px solid red;
    }

    .childItem {
      width: 30px;
      height: 30px;
      position: absolute;
      border: 1px solid red;
      margin-left: 10px;
    }
  </style>
  <script src="./lib/jquery.js"></script>
</head>

<body>
  <!--  <div id="copy">dcopy </div>
  <script>
    var copyDom = document.getElementById('copy');
    var range = document.createRange();
    range.selectNode(copyDom);
    window.getSelection().removeAllRanges();
    window.getSelection().addRange(range);
    var a = document.execCommand('copy');
  </script> -->
  <div style="width: 1000px;height: 400px;border: 1px solid #ccc;position: relative;overflow: scroll;" id="container">
    <div id="parent1" class="topo_group">
      <div class="title">title0</div>
      <div class="child">
        <div class="childItem"></div>
        <div class="childItem"></div>
      </div>
      <div class="child"></div>
    </div>
    <div class="topo_group">
      <div class="title">title1</div>
      <div class="child">
        <div class="childItem"></div>
        <div class="childItem"></div>
      </div>
    </div>
    <!-- <div class="topo_group"></div> -->
  </div>
  <script>
    /*
     topo_group的高度定为300px,宽度不定
     childItem的宽度高度固定
    */
    let containerEle = $('#container');
    let parentEle = $('#container .topo_group');

    setParentWidth();

    // 设置父元素的宽度
    function setParentWidth() {
      for (var parentIndex = 0, parentLen = parentEle.length; parentIndex < parentLen; parentIndex++) {
        let parentChildEle = $(parentEle[parentIndex]).find('.childItem');
        if (parentChildEle.length > 0) {
          let childWidth = parentChildEle[0].offsetWidth;
          $(parentEle[parentIndex]).css('width', function () {
            return (parseInt(parentChildEle.css('marginLeft')) + childWidth) *
              parentChildEle
              .length +
              parseInt(parentChildEle.css('marginLeft')) + 'px';
          });
        }
      }
    }

    function setChildPosition() {

    }

    setParentPosition();

    // 根据连线关系固定父组件的位置
    function setParentPosition() {
      // 定义第一个默认位置为
      var positionTop = 20;
      var positionLeft = parseInt(containerEle.css("width")) / 2 - parseInt(parentEle.css("width")) / 2;
      if (parentEle.length === 1) {
        positionTop = parseInt(containerEle.css("height")) / 2 - parseInt(parentEle.css("height")) / 2;
        parentEle.css('top', function () {
          return positionTop + 'px';
        });
        parentEle.css('left', function () {
          return positionLeft + 'px';
        });
      } else if (parentEle.length === 2) {
        // 上下排列
        var circleHeight = 50;
        for (var i = 0, len = parentEle.length; i < len; i++) {
          var parentObj = $(parentEle[i]);
          if (i === 1) {
            positionTop = 20 + parseInt(parentObj.css("height")) + circleHeight;
          }
          parentObj.css('top', function () {
            return positionTop + 'px';
          });
          parentObj.css('left', function () {
            return parseInt(containerEle.css("width")) / 2 - parseInt(parentObj.css("width")) / 2 + 'px';
          });
        }
      } else if (parentEle.length === 3) {
        // 三角形排列
        var circleHeight = 50;
        for (var i = 0, len = parentEle.length; i < len; i++) {
          var parentObj = $(parentEle[i]);
          if (i === 1 || i === 2) {
            positionTop = 20 + parseInt(parentObj.css("height")) + circleHeight;
          }
          positionLeft = parseInt(containerEle.css("width")) / 2 - parseInt(parentObj.css("width")) / 2;
          if (i === 1) {
            positionLeft = parseInt(containerEle.css("width")) / 2 - circleHeight / 2 - parseInt(parentObj.css(
              "width"));
          } else if (i === 2) {
            positionLeft = parseInt(containerEle.css("width")) / 2 + circleHeight / 2;
          }
          parentObj.css('top', function () {
            return positionTop + 'px';
          });
          parentObj.css('left', function () {
            return positionLeft + 'px';
          });
        }
      } else if (parentEle.length === 4) {
        // 菱形排列
        for (var i = 0, len = parentEle.length; i < len; i++) {
          var parentObj = $(parentEle[i]);
          if (i === 1 || i === 2) {
            positionTop = 20 + parseInt(parentObj.css("height")) + circleHeight;
          } else if (i === 3) {
            positionTop = 20 + (parseInt(parentObj.css("height")) + circleHeight) * 2;
          }
          positionLeft = parseInt(containerEle.css("width")) / 2 - parseInt(parentObj.css("width")) / 2;
          if (i === 1) {
            positionLeft = parseInt(containerEle.css("width")) / 2 - circleHeight / 2 - parseInt(parentObj.css(
              "width"));
          } else if (i === 2) {
            positionLeft = parseInt(containerEle.css("width")) / 2 + circleHeight / 2;
          }
          parentObj.css('top', function () {
            return positionTop + 'px';
          });
          parentObj.css('left', function () {
            return positionLeft + 'px';
          });
        }
      } else if (parentEle.length === 5) {
        // 五边形排列
        for (var i = 0, len = parentEle.length; i < len; i++) {
          var parentObj = $(parentEle[i]);
          if (i === 1 || i === 2) {
            positionTop = 20 + parseInt(parentObj.css("height")) + circleHeight;
          } else if (i === 3) {
            positionTop = 20 + (parseInt(parentObj.css("height")) + circleHeight) * 2;
          }
          positionLeft = parseInt(containerEle.css("width")) / 2 - parseInt(parentObj.css("width")) / 2;
          if (i === 1) {
            positionLeft = parseInt(containerEle.css("width")) / 2 - circleHeight / 2 - parseInt(parentObj.css(
              "width"));
          } else if (i === 2) {
            positionLeft = parseInt(containerEle.css("width")) / 2 + circleHeight / 2;
          }
          parentObj.css('top', function () {
            return positionTop + 'px';
          });
          parentObj.css('left', function () {
            return positionLeft + 'px';
            150 / Math.sin(18 * (Math.PI / 180))
          });
        }
      }
    }
  </script>
  <script>
    /* var a = {
      nodes: {
        lists: [{
          ID: "vpc1.1",
          group: "group1",
          type: "vpc"
        }, {
          ID: "vpc2.1",
          group: "group1",
          type: "vpc"
        }, {
          ID: "vpc3.1",
          group: "group2",
          type: "vpc"
        }, {
          ID: "vpc4.1",
          group: "group2",
          type: "vpc"
        }, {
          ID: "vpc5.1",
          group: "group3",
          type: "vpc"
        }, {
          ID: "vpc6.1",
          group: "group3",
          type: "vpc"
        }, {
          ID: "xgw1.2",
          type: "xgw"
        }]
      },
      edges: {
        lists: [{
          source: "vpc1.1",
          target: "xgw1.2"
        }, {
          source: "vpc2.1",
          target: "xgw2.2"
        }, {
          source: "vpc3.1",
          target: "xgw3.2"
        }, {
          source: "vpc4.1",
          target: "xgw4.2"
        }, {
          source: "vpc5.1",
          target: "xgw5.2"
        }, {
          source: "vpc6.1",
          target: "xgw6.2"
        }, {
          source: "vpc7.1",
          target: "xgw7.2"
        }]
      }
    }

    let idMapType = {};
    let idMapGroup = {};
    let params = {};
    let edges = [];
    a.nodes.lists.forEach(function (item) {
      idMapType[item.ID] = item.type;
      idMapGroup[item.ID] = item.group;
      if (item.group) {
        params[item.group] = params[item.group] || {};
        params[item.group][item.type] = params[item.group][item.type] || {};
        params[item.group]["threeNum"] = 0;
        params[item.group][item.type][item.ID] = item;
      }
    });
    a.edges.lists.forEach(function (item) {
      if (idMapGroup[item.source]) {
        idMapGroup[item.target] = idMapGroup[item.source];
        params[idMapGroup[item.source]]["threeNum"]++;
        params[idMapGroup[item.source]][idMapType[item.target]] = params[idMapGroup[item.source]][
          idMapType[item.target]
        ] || {};
        params[idMapGroup[item.source]][idMapType[item.target]][item.target] = item;
      }
      if (idMapGroup[item.target]) {
        idMapGroup[item.source] = idMapGroup[item.target];
        params[idMapGroup[item.target]]["threeNum"]++;
        params[idMapGroup[item.target]][idMapType[item.source]] = params[idMapGroup[item.target]][
          idMapType[item.source]
        ] || {};
        params[idMapGroup[item.source]][idMapType[item.source]][item.source] = item;
      }
    });

    console.log(idMapType)
    console.log(idMapGroup)
    console.log(params) */
  </script>

</body>

</html>
