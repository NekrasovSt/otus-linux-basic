<?php
/**
 * Основные параметры WordPress.
 *
 * Скрипт для создания wp-config.php использует этот файл в процессе
 * установки. Необязательно использовать веб-интерфейс, можно
 * скопировать файл в "wp-config.php" и заполнить значения вручную.
 *
 * Этот файл содержит следующие параметры:
 *
 * * Настройки MySQL
 * * Секретные ключи
 * * Префикс таблиц базы данных
 * * ABSPATH
 *
 * @link https://ru.wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Параметры MySQL: Эту информацию можно получить у вашего хостинг-провайдера ** //
/** Имя базы данных для WordPress */
define( 'DB_NAME', 'wordpress' );

/** Имя пользователя MySQL */
define( 'DB_USER', 'wordpressuser' );

/** Пароль к базе данных MySQL */
define( 'DB_PASSWORD', 'P@ssw0rd' );

/** Имя сервера MySQL */
define( 'DB_HOST', '185.177.92.101' );

/** Кодировка базы данных для создания таблиц. */
define( 'DB_CHARSET', 'utf8mb4' );

/** Схема сопоставления. Не меняйте, если не уверены. */
define( 'DB_COLLATE', '' );

/**#@+
 * Уникальные ключи и соли для аутентификации.
 *
 * Смените значение каждой константы на уникальную фразу.
 * Можно сгенерировать их с помощью {@link https://api.wordpress.org/secret-key/1.1/salt/ сервиса ключей на WordPress.org}
 * Можно изменить их, чтобы сделать существующие файлы cookies недействительными. Пользователям потребуется авторизоваться снова.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'S.=`Rhf19pFhT-/.@^9jG*t|L9FLjLFGGneO&[}g:ptu_werluk,Lbd<@D-h%Rdj' );
define( 'SECURE_AUTH_KEY',  'gfX|?!(C:1^%tcf@?AKpDw1eEJ,NDB^$~GI8gP#*{MybLTkol%(|otBdo^(~:fz=' );
define( 'LOGGED_IN_KEY',    'Z3wiUbebReBzURED>Ts#Tes^[7DH==j_:rf-}PZ!2$Mx)HFk?up`9WE9>uXDYAj~' );
define( 'NONCE_KEY',        'Vx9CmR.&2J)jeCi(VAG#We7L*z?WZ[MA^KW8cUUJd_],hCDRXgUtht9U5y=$S8 3' );
define( 'AUTH_SALT',        '-{E[<.~IHd2f:O4IN_+%_RlgV,hATjW*:yQI1>gq#1fk>^(#lU7hf. Nh~MiEdrH' );
define( 'SECURE_AUTH_SALT', '(T_pOlQ2Ge]_LT`haX2#<)[CJZjnAJY$0UORspF>}| DB290Dg*2?s@&wI{-VOHM' );
define( 'LOGGED_IN_SALT',   'Xxj(-Esv/4B+HW:Ba%+Q^7j{N8QuA]i-!iIMSQpka]jKC%P7Ehp.QFnGQ An,WbO' );
define( 'NONCE_SALT',       'doQIDq@Qs.ln?C~9:PUG}{}4kAvgT.8 8bCU6jLE4TP9`0)mDT]Bd%(T4,^Hs!(t' );

/**#@-*/

/**
 * Префикс таблиц в базе данных WordPress.
 *
 * Можно установить несколько сайтов в одну базу данных, если использовать
 * разные префиксы. Пожалуйста, указывайте только цифры, буквы и знак подчеркивания.
 */
$table_prefix = 'wp_';

/**
 * Для разработчиков: Режим отладки WordPress.
 *
 * Измените это значение на true, чтобы включить отображение уведомлений при разработке.
 * Разработчикам плагинов и тем настоятельно рекомендуется использовать WP_DEBUG
 * в своём рабочем окружении.
 *
 * Информацию о других отладочных константах можно найти в документации.
 *
 * @link https://ru.wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* Это всё, дальше не редактируем. Успехов! */

/** Абсолютный путь к директории WordPress. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Инициализирует переменные WordPress и подключает файлы. */
require_once ABSPATH . 'wp-settings.php';
