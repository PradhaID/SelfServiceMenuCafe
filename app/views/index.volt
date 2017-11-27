<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
 		<link rel="stylesheet" href="{{ url('css/semantic.min.css') }}">
        <link rel="stylesheet" href="{{ url('css/style.css') }}">
        <link rel="stylesheet" href="{{ url('css/jquery-confirm.css') }}">
        <link rel="stylesheet" href="{{ url('css/swiper.min.css') }}">
		{{ javascript_include("js/jquery.min.js") }}
        {{ javascript_include("js/semantic.min.js") }}
        {{ javascript_include("js/jquery-confirm.js") }}
        {{ javascript_include("js/swiper.min.js") }}
        <title>Sultan Cafe</title>
    </head>
    <body>
            {{ content() }}
    </body>
</html>
