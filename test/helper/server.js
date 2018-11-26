var io = require('socket.io').listen(3000);
io.on('connection', function (socket) {
    console.log('connected:', socket.client.id);
    socket.on('DataPurchased', function (data) {
        console.log('new message from client:', data);
    });
    setInterval(function () {
        socket.emit('streamdata', Math.random());
        console.log('message sent to the clients');
    }, 3000);
});