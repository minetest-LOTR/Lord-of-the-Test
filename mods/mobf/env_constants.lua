-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--
--! @file env_constants.lua
--! @brief constants used for environmental functions
--! @copyright Sapier
--! @author Sapier
--! @date 2013-08-17
--
--! @defgroup environment Environment subcomponent
--! @brief Environment check functions used by different subcomponents
--! @ingroup framework_int
--! @{
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

MQ_IN_MEDIA = 100
MQ_IN_WATER =  20
MQ_IN_AIR   =  10
MQ_SOLID    =   5

GQ_FULL     = 100
GQ_PARTIAL  =  60
GQ_NONE     =  30

SQ_OK       = 100
SQ_POSSIBLE =  60
SQ_WRONG    =  30
SQ_WATER    =  10

LQ_OK       = 100
LQ_ABOVE    =  60
LQ_BELOW    =  30

Q_UNKNOWN   =   0

--define some common limits for convenience

--! @brief a position where mob is in media, has full surface contact and is at least on a possible surface
LT_GOOD_POS = {
	old_state=nil,
	min_media=MQ_IN_MEDIA,
	min_geom=GQ_FULL,
	min_geom_center=nil,
	min_min_surface=SQ_POSSIBLE,
	min_max_surface=SQ_OK,
	min_center_surface=nil
}

LT_GOOD_FLY_POS = {
	old_state=nil,
	min_media=MQ_IN_MEDIA,
	min_geom=nil,
	min_geom_center=nil,
	min_min_surface=Q_UNKNOWN,
	min_max_surface=Q_UNKNOWN,
	min_center_surface=nil
}

--! @brief a position where mob is in media, has surface contact and is at least on a possible surface
LT_SAFE_POS = {
	old_state=nil,
	min_media=MQ_IN_MEDIA,
	min_geom=GQ_PARTIAL,
	min_geom_center=nil,
	min_min_surface=nil,
	min_max_surface=SQ_POSSIBLE,
	min_center_surface=nil
}

--! @brief a position where mob is in media, it's center has surface contact and is at least on a possible surface
LT_SAFE_EDGE_POS = {
	old_state=nil,
	min_media=MQ_IN_MEDIA,
	min_geom=nil,
	min_geom_center=GQ_FULL,
	min_min_surface=SQ_POSSIBLE,
	min_max_surface=SQ_OK,
	min_center_surface=nil
}

--! @brief a position where mob is in media, it's center has surface contact and is on a possible surface
LT_SAFE_POSSIBLE_EDGE_POS = {
	old_state=nil,
	min_media=MQ_IN_MEDIA,
	min_geom=nil,
	min_geom_center=GQ_FULL,
	min_min_surface=SQ_POSSIBLE,
	min_max_surface=SQ_POSSIBLE,
	min_center_surface=nil
}

--! @brief a position where mob is in media, it's center has surface contact and it's center is at least on a possible surface
LT_EDGE_POS_POSSIBLE_CENTER = {
	old_state=nil,
	min_media=MQ_IN_MEDIA,
	min_geom=nil,
	min_geom_center=GQ_FULL,
	min_min_surface=nil,
	min_max_surface=nil,
	min_center_surface=SQ_POSSIBLE
}

--! @brief a position where mob is in media, it's center has surface contact and it's center is at least on a good surface
LT_EDGE_POS_GOOD_CENTER = {
	old_state=nil,
	min_media=MQ_IN_MEDIA,
	min_geom=nil,
	min_geom_center=GQ_FULL,
	min_min_surface=nil,
	min_max_surface=nil,
	min_center_surface=SQ_OK
}

--! @brief a position where mob is in media, has at least partial contact and is at least on possible surface
LT_EDGE_POS = {
	old_state=nil,
	min_media=MQ_IN_MEDIA,
	min_geom=GQ_PARTIAL,
	min_geom_center=nil,
	min_min_surface=SQ_POSSIBLE,
	min_max_surface=SQ_OK,
	min_center_surface=nil
}

--! @brief a position where mob is in media, has at least partial contact but no contact at center
LT_DROP_PENDING = {
	old_state=nil,
	min_media=MQ_IN_MEDIA,
	min_geom=GQ_PARTIAL,
	min_geom_center=GQ_NONE,
	min_min_surface=nil,
	min_max_surface=nil,
	min_center_surface=nil
}