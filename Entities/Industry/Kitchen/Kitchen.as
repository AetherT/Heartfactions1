﻿// SlaveOwnersShop.as

#include "Requirements.as"
#include "ShopCommon.as"
#include "Descriptions.as"
#include "Costs.as"
#include "CheckSpam.as"

void onInit(CBlob@ this)
{
	InitCosts(); //read from cfg

	AddIconToken("$_buildershop_filled_bucket$", "Bucket.png", Vec2f(16, 16), 1);

	this.set_TileType("background tile", CMap::tile_wood_back);

	this.getSprite().SetZ(-50); //background
	this.getShape().getConsts().mapCollisions = false;

	// SHOP
	this.set_Vec2f("shop offset", Vec2f_zero);
	this.set_Vec2f("shop menu size", Vec2f(4, 4));
	this.set_string("shop description", "Buy");
	this.set_u8("shop icon", 25);

	{
		ShopItem@ s = addShopItem(this, "Corn On The Cob", "$cornonthecob$", "cornonthecob", "Its cooked corn, on a stick?", false);
		AddRequirement(s.requirements, "blob", "corn", "Corn", 1);
	}
	{
		ShopItem@ s = addShopItem(this, "Bread", "$bread$", "bread", "Freshly baked bread.", false);
		AddRequirement(s.requirements, "blob", "flour", "Flour", 3);
		AddRequirement(s.requirements, "blob", "egg", "Egg", 1);
	}
	{
		ShopItem@ s = addShopItem(this, "Kebab", "$kebab$", "kebab", "Cooked meat and greens threaded on a stick.", false);
		AddRequirement(s.requirements, "blob", "cookedmeat", "Cooked Meat", 1);
		AddRequirement(s.requirements, "blob", "lettuce", "Lettuce", 1);
	}
	{
		ShopItem@ s = addShopItem(this, "Roasted Carrots", "$roastedcarrot$", "roastedcarrot", "Fire roasted carrots, deleciously tender.", false);
		AddRequirement(s.requirements, "blob", "carrot", "Carrot", 1);
	}
	{
		ShopItem@ s = addShopItem(this, "Cooked Egg", "$cookedegg$", "cookedegg", "A sunny side up cooked egg.", false);
		AddRequirement(s.requirements, "blob", "egg", "Egg", 1);
	}
	{
		ShopItem@ s = addShopItem(this, "Cooked Meat", "$cookedmeat$", "cookedmeat", "Grilled meat.", false);
		AddRequirement(s.requirements, "blob", "rawmeat", "RawMeat", 1);
	}
	{
		ShopItem@ s = addShopItem(this, "Cooked Fish", "$cookedfish$", "cookedfish", "A grilled fish.", false);
		AddRequirement(s.requirements, "blob", "fishy", "Fishy", 1);
	}
}

void GetButtonsFor(CBlob@ this, CBlob@ caller)
{
	if(caller.getConfig() == this.get_string("required class"))
	{
		this.set_Vec2f("shop offset", Vec2f_zero);
	}
	else
	{
		this.set_Vec2f("shop offset", Vec2f(6, 0));
	}
	this.set_bool("shop available", this.isOverlapping(caller));
}

void onCommand(CBlob@ this, u8 cmd, CBitStream @params)
{
	if (cmd == this.getCommandID("shop made item"))
	{
		this.getSprite().PlaySound("/ChaChing.ogg");

		if(!getNet().isServer()) return; /////////////////////// server only past here

		u16 caller, item;
		if (!params.saferead_netid(caller) || !params.saferead_netid(item))
		{
			return;
		}
		string name = params.read_string();
		{
			CBlob@ callerBlob = getBlobByNetworkID(caller);
			if (callerBlob is null)
			{
				return;
			}

			if (name == "filled_bucket")
			{
				CBlob@ b = server_CreateBlobNoInit("bucket");
				b.setPosition(callerBlob.getPosition());
				b.server_setTeamNum(callerBlob.getTeamNum());
				b.Tag("_start_filled");
				b.Init();
				callerBlob.server_Pickup(b);
			}
		}
	}
}
