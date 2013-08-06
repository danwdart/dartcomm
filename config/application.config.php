<?php
return array(
    'modules' => array(
        'Application',
    ),
    'module_listener_options' => array(
        'module_paths' => array(
            './module',
            './vendor',
        ),
        'config_glob_paths' => array(
            'config/autoload/{,*.}{global,local}.php',
        ),
        //'config_cache_enabled' => $booleanValue,
        //'config_cache_key' => $stringKey,
        //'module_map_cache_enabled' => $booleanValue,
        //'module_map_cache_key' => $stringKey,
        //'cache_dir' => $stringPath,
        // 'check_dependencies' => true,
    ),
    //'service_listener_options' => array(
    //     array(
    //         'service_manager' => $stringServiceManagerName,
    //         'config_key'      => $stringConfigKey,
    //         'interface'       => $stringOptionalInterface,
    //         'method'          => $stringRequiredMethodName,
    //     ),
    // )
    // 'service_manager' => array(),
);
