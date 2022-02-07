<?php

require_once 'mysqly.php';

mysqly::auth('ecom', 'ecom', 'ecomtrack');

/* for ( $i = 0; $i < 50; $i++ ) {
  mysqly::insert('users', [
    'email' => substr(md5(mt_rand(1, 999999)), 0, mt_rand(5, 10)) . '@gmail.com',
    'pwd' => sha1(mt_rand(1, 999999)),
    'status' => mt_rand(0, 1) ? 'new' : 'confirmed',
    'created_at' => date('Y-m-d H:i:s', time() - mt_rand(1, 9999999))
  ]);
} */

/*$s = ['pending', 'paid', 'delivered', 'canceled'];
for ( $i = 0; $i < 100; $i++ ) mysqly::insert('orders', [
  'user_id' => mt_rand(101, 150),
  'created_at' => date('Y-m-d H:i:s', time() - mt_rand(1, 60*60*24*3)),
  'status' => $s[array_rand($s)]
]);*/

/*`for ( $i = 0; $i < 100; $i++ ) {
  mysqly::insert('sessions', [
    'created_at' => date('Y-m-d H:i:s', time() - mt_rand(60*60*24, 60*60*24*3)),
    'user_id' => mt_rand(101, 150),
    'visitor_id' => mt_rand(1, 101)
  ]);
}`*/


for ( $i = 0; $i < 100; $i++ ) {
  $o_id = mt_rand(1, 10);
  $c_id = mysqly::insert('context', [
    'type' => 'category',
    'object_id' => $o_id
  ], true);

  if ( !$c_id ) {
    $c_id = mysqly::context_id(['type' => 'category', 'object_id' => $o_id]);
  }

  if ( $c_id ) mysqly::insert('events', [
    'at' => date('Y-m-d H:i:s', time() - mt_rand(1, 60*60*24*3)),
    'session_id' => mt_rand(1, 100),
    'context_id' => $c_id,
    'type' => 2
  ]);
}
