#include "Hitters.as";
//Top shotgun

const uint8 FIRE_INTERVAL = 12;
const float BULLET_DAMAGE = 6; //3.
const uint8 PROJECTILE_SPEED = 25;
const float TIME_TILL_DIE = 0.8;

const uint8 CLIP = 32;
const uint8 TOTAL = 86;
const uint8 RELOAD_TIME = 65;

const string AMMO_TYPE = "bullet";
const bool SNIPER = false;
const uint8 SNIPER_TIME = 0;

const string FIRE_SOUND = "shotgun.ogg";
const string RELOAD_SOUND  = "Reload.ogg";

const Vec2f RECOIL = Vec2f(1.0f,0.0);
const float BULLET_OFFSET_X = 6;
const float BULLET_OFFSET_Y = 0;

#include "ShotgunFire.as";
#include "ShotgunStandard.as";
