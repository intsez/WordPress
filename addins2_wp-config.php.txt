
/** WordPress additional rules (Single Database Only) **/
/** ------------------------------------------------- **/

/** Force URI Structure */
// define('WP_HOME', 'https://change-me');
// define('WP_SITEURL', 'https://change-me');
// define('WP_CONTENT_URL', 'https://change-me/wp-content');
// define('WP_PLUGIN_URL', 'https://change-me/wp-content/plugins');
// define('WP_CONTENT_DIR', '/wp-content');
// define('WP_PLUGIN_DIR', '/wp-content/plugins');
// define('WP_LANG_DIR', '/wp-content/languages');

/* Change default uploads folder, provide valid path */
// define('UPLOADS', '/wp-content/uploads');
/* or */
// define('UPLOADS', 'wp-content/uploads/'.'images' );
/* Change default temp folder, provide valid path */
// define('WP_TEMP_DIR', dirname(__FILE__) . '/wp-content/uploads/temp/');

/* Default Theme name */
// define('WP_DEFAULT_THEME', 'change_my_name');

/** Force HTTPS Backend */
// define('FORCE_SSL_ADMIN', true);
// define('FORCE_SSL_LOGIN', true);

/** Cookie Paths */
// define('ADMIN_COOKIE_PATH', '/');
// define('COOKIE_DOMAIN', 'change URI');
// define('COOKIEPATH', '');
// define('SITECOOKIEPATH', '');

/** Debug Settings - only for developement and debugginf, should br never be enabled on production (live) website */
/* if 'true' this turns on development Environment*/
// define('WP_LOCAL_DEV', false);

/* Repairs broken tables. After setting this to 'true' copy/paste this URI to your web browser and press Enter:
   http://cheng.me/wp-admin/maint/repair.php   */
// define('WP_ALLOW_REPAIR', true);
/* sets PHP error_reporting to E_ALL rather than 4339 */
// define('WP_DEBUG', false);

/* Disable display of errors and warnings */
// define('WP_DEBUG_DISPLAY', false);
/* Use dev versions of core JS and CSS files (only needed if you are modifying these core files) */
// define( 'SCRIPT_DEBUG', true );
// define('SAVEQUERIES', false);

/* Enable Debug logging to the /wp-content/debug.log file */
// define('WP_DEBUG_LOG', true);
//// ini_set('log_errors', 'On');
//// ini_set('error_log', '/var/logs/wperror.log');

/** WordPress Core: Cache Settings (Page Caching Done By Nginx FastCGI Cache) **/
/* Adds wp-content/advanced-cache.php while execute wp-settings.php */
// define('WP_CACHE', false);

/* enable/disable automatic updtes - 'true' improves security */
define('AUTOMATIC_UPDATER_DISABLED', true);
// define('WP_AUTO_UPDATE_CORE', false); 
/* 'true' – Development, minor, and major updates are all enabled
  'false' – Development, minor, and major updates are all disabled
  'minor' – Minor updates are enabled, development, and major updates are disabled*/
/* disble update of wp-content*/
define('CORE_UPGRADE_SKIP_NEW_BUNDLED', true);

/** WordPress Core: File + Upload + API Permission Settings **/
/* Block all outgoing network requests from your site*/
define('WP_HTTP_BLOCK_EXTERNAL', true);
/* whitelist for abowe e.g. 'api.wordpress.org,www.change_me.io' */
//define('WP_ACCESSIBLE_HOSTS', 'api.wordpress.org,www.change_me.io');
/* If user calls non existing URI e.g. http://URI/something/ or http://nonexisting.uri.com redirects to provided URI */
//define( 'NOBLOGREDIRECT', 'change.me' );

/** File Modifying **/
/* disable to install themes, plugins and edit all files from Admin API aftre login */
define('DISALLOW_FILE_MODS', true);
/* disable only editing files from Admin API */
// define('DISALLOW_FILE_EDIT', 'true');

/** Default File Permissions **/
define('FS_METHOD', 'direct');
define('FS_CHMOD_DIR', (0775 & ~ umask()));
define('FS_CHMOD_FILE', (0664 & ~ umask()));

/** File (Media) Uploads */
/* Only Adminstrators are allowed to upload whatever they want, set 'true' to allow all */
define('ALLOW_UNFILTERED_UPLOADS', false);

/** HTML Settings */
/* if 'false' only Admins and redactors can publish unfiltered html in posts and comments*/
define('DISALLOW_UNFILTERED_HTML', false);

/** WordPress Core: Other Language Settings */
// define('WPLANG', '@WP_LANG');
// require_once( dirname( __FILE__ ) . '/wp-lang.php');

/** WordPress Core: Various Performance Settings */
/* Memory */
define('WP_MEMORY_LIMIT', '128M');
define('WP_MAX_MEMORY_LIMIT', '256M');

/* Delete additonal pictures after editing old ones*/
define( 'IMAGE_EDIT_OVERWRITE', true );

/** Trash Settings */
define('MEDIA_TRASH', true);
define('EMPTY_TRASH_DAYS', 99999999999999999999);

/** Post Revisions + Drafts */
define('WP_POST_REVISIONS', 5); // how many revisions
define('AUTOSAVE_INTERVAL', 30); // in seconds

/** WP-Cron Settings - runs script on website with huge traffic */
/* on off wp_cron */
// define('DISABLE_WP_CRON', false);
/* how often wp_cron works */
// define('WP_CRON_LOCK_TIMEOUT', 300); // 300 sek = (5 minutes)
// define('ALTERNATE_WP_CRON', false);

/** PHP Optimization */
// define('ENFORCE_GZIP', false);
/* 'false' sometimes repairs scripts after update */
// define('CONCATENATE_SCRIPTS', false);
// define('COMPRESS_CSS', false);
// define('COMPRESS_SCRIPTS', false);

/* WordPress Core Environment Settings **/
/** Disable Nag Notices - some plugin offers update to premium and shows many annoying notices */
define('DISABLE_NAG_NOTICES', true);

/** Contact Form 7 Temp Directory - provide valid path */
//define('WPCF7_UPLOADS_TMP_DIR', '/var/www/wordpress/wp-content/temp'); 
