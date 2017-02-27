
var JSSendMessageWithMoreParam = function(value1,value2){
    jsIdentify.sendMessageWithMoreParam(value1,value2)
}

var sendMessageToJSNoParam = function(){
    alert("收到从webView发来的消息")
}

var sendMessageToJSWithOneParam = function(value){
    alert("收到从webView发来的消息，参数："+value)
}

var sendMessageToJSWithMoreParam = function(value1,value2){
    alert("收到从webView发来的消息，参数："+value1+value2)
}

var WKsendMessageToOCWithMoreParam = function(){
    window.webkit.messageHandlers.handlerName.postMessage({functionName: 'sendMessageFromWKWithMoreParam',param:'WkGetTheMessageFromJS'})
}

var sendMessageFromWKWithMoreParam = function(value){
    alert("收到从WK发来的消息，参数"+value)
}
