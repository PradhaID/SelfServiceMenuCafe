<?php

use Phalcon\Mvc\View;
use Phalcon\Mvc\View\Engine\Php as PhpEngine;
use Phalcon\Mvc\Url as UrlResolver;
use Phalcon\Mvc\View\Engine\Volt as VoltEngine;
use Phalcon\Mvc\Model\Metadata\Memory as MetaDataAdapter;
use Phalcon\Session\Adapter\Files as SessionAdapter;
use Phalcon\Flash\Direct as Flash;

/**
 * Shared configuration service
 */
$di->setShared('config', function () {
    return include APP_PATH . "/config/config.php";
});

/**
 * The URL component is used to generate all kind of urls in the application
 */
$di->setShared('url', function () {
    $config = $this->getConfig();

    $url = new UrlResolver();
    $url->setBaseUri($config->application->baseUri);

    return $url;
});

/**
 * Setting up the view component
 */
$di->setShared('view', function () {
    $config = $this->getConfig();

    $view = new View();
    $view->setDI($this);
    $view->setViewsDir($config->application->viewsDir);

    $view->registerEngines([
        '.volt' => function ($view) {
            $config = $this->getConfig();

            $volt = new VoltEngine($view, $this);

            $volt->setOptions([
                'compiledPath' => $config->application->cacheDir,
                'compiledSeparator' => '_',
                'compileAlways' => true
            ]);
            $compiler = $volt->getCompiler();
            $compiler->addFunction(
                'haveRole',
                function ($resolvedArgs, $exprArgs) {
                    $session = new SessionAdapter();
                    if ($session->get('group')==""){
                        echo "No Group";
                        exit;
                    }
                    return "haveRole(".$session->get('group').",$resolvedArgs)";
                }
            );
            $compiler->addFunction(
                'strtotime',
                function ($resolvedArgs, $exprArgs) {
                    return "strtotime($resolvedArgs)";
                }
            );
            $compiler->addFilter(
                'numberFormat',
                function ($resolvedArgs, $exprArgs) use ($compiler) {
                    return 'number_format('.$resolvedArgs.',2)';
                }
            );
            $compiler->addFilter(
                'simpleNumberFormat',
                function ($resolvedArgs, $exprArgs) use ($compiler) {
                    return 'number_format('.$resolvedArgs.',0)';
                }
            );
            $compiler->addFilter(
                'dateFormat',
                function ($resolvedArgs, $exprArgs) use ($compiler) {
                    return "date('d M Y', strtotime($resolvedArgs))";
                }
            );
            $compiler->addFilter(
                'dateTimeFormat',
                function ($resolvedArgs, $exprArgs) use ($compiler) {
                    return "date('d M Y H:i:s', strtotime($resolvedArgs))";
                }
            );
            $compiler->addFilter(
                'encode',
                function ($resolvedArgs, $exprArgs) use ($compiler) {
                    return "encode($resolvedArgs)";
                }
            );
            $compiler->addFilter(
                'decode',
                function ($resolvedArgs, $exprArgs) use ($compiler) {
                    return "decode($resolvedArgs)";
                }
            );
            return $volt;
        },
        '.phtml' => PhpEngine::class

    ]);

    return $view;
});

/**
 * Database connection is created based in the parameters defined in the configuration file
 */
$di->setShared('db', function () {
    $config = $this->getConfig();

    $class = 'Phalcon\Db\Adapter\Pdo\\' . $config->database->adapter;
    $params = [
        'host'     => $config->database->host,
        'username' => $config->database->username,
        'password' => $config->database->password,
        'dbname'   => $config->database->dbname
    ];

    if ($config->database->adapter == 'Postgresql') {
        unset($params['charset']);
    }

    $connection = new $class($params);

    return $connection;
});


/**
 * If the configuration specify the use of metadata adapter use it or use memory otherwise
 */
$di->setShared('modelsMetadata', function () {
    return new MetaDataAdapter();
});

/**
 * Register the session flash service with the Twitter Bootstrap classes
 */
$di->set('flash', function () {
    return new Flash([
        'error'   => 'alert alert-danger',
        'success' => 'alert alert-success',
        'notice'  => 'alert alert-info',
        'warning' => 'alert alert-warning'
    ]);
});

/**
 * Start the session the first time some component request the session service
 */
$di->setShared('session', function () {
    $session = new SessionAdapter();
    $session->start();

    return $session;
});

function subCategory($parent, $type=null, $productCat=null){
    $categories=Category::find(array("conditions"=>"parent='".$parent."'"));
    if ($type=="checkbox"){
        foreach ($categories as $category){
            ?>
            <div class="item">
                <div class="ui child checkbox">
                    <input type="checkbox" value="<?= $category->id; ?>" name="category[]" <?php if (in_array_multi($category->id,$productCat)) echo 'checked'; ?>>
                    <label><?= $category->name; ?></label>
                </div>
            </div>
            <?php
        }
    }else if ($type=="item"){
        foreach ($categories as $category){
            ?>
            <div class="item" data-value="<?= $category->id; ?>"><?= $category->name; ?></div>
            <?php
        }
    }
}
function encode($string){
    return str_replace(array('+', '/'), array('-', '_'), base64_encode(gzdeflate($string)));
}
function decode($string){
    return gzinflate(base64_decode(str_replace(array('-', '_'), array('+', '/'),$string)));
}
function haveRole($group, $role){

    $check=GroupHaveRole::Find("group_id='".$group."' AND role_id='".$role."'");
    if (count($check)>=1) return true;
    else return false;
}
if(!function_exists('mime_content_type')) {

    function mime_content_type($file) {

        $mime_types = array(

            'txt' => 'text/plain',
            'htm' => 'text/html',
            'html' => 'text/html',
            'php' => 'text/html',
            'css' => 'text/css',
            'js' => 'application/javascript',
            'json' => 'application/json',
            'xml' => 'application/xml',
            'swf' => 'application/x-shockwave-flash',
            'flv' => 'video/x-flv',

            // images
            'png' => 'image/png',
            'jpe' => 'image/jpeg',
            'jpeg' => 'image/jpeg',
            'jpg' => 'image/jpeg',
            'gif' => 'image/gif',
            'bmp' => 'image/bmp',
            'ico' => 'image/vnd.microsoft.icon',
            'tiff' => 'image/tiff',
            'tif' => 'image/tiff',
            'svg' => 'image/svg+xml',
            'svgz' => 'image/svg+xml',

            // archives
            'zip' => 'application/zip',
            'rar' => 'application/x-rar-compressed',
            'exe' => 'application/x-msdownload',
            'msi' => 'application/x-msdownload',
            'cab' => 'application/vnd.ms-cab-compressed',

            // audio/video
            'mp3' => 'audio/mpeg',
            'qt' => 'video/quicktime',
            'mov' => 'video/quicktime',

            // adobe
            'pdf' => 'application/pdf',
            'psd' => 'image/vnd.adobe.photoshop',
            'ai' => 'application/postscript',
            'eps' => 'application/postscript',
            'ps' => 'application/postscript',

            // ms office
            'doc' => 'application/msword',
            'rtf' => 'application/rtf',
            'xls' => 'application/vnd.ms-excel',
            'ppt' => 'application/vnd.ms-powerpoint',

            // open office
            'odt' => 'application/vnd.oasis.opendocument.text',
            'ods' => 'application/vnd.oasis.opendocument.spreadsheet',
        );

        $ext = strtolower(array_pop(explode('.',$file)));
        if (array_key_exists($ext, $mime_types)) {
            return $mime_types[$ext];
        }
        elseif (function_exists('finfo_open')) {
            $finfo = finfo_open(FILEINFO_MIME);
            $mimetype = finfo_file($finfo, $file);
            finfo_close($finfo);
            return $mimetype;
        }
        else {
            return 'application/octet-stream';
        }
    }
}