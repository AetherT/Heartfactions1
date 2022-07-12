#include "Help.as";

void onInit( CBlob@ this )
{
	HelpText help;
	this.addCommandID( "eat" );
	SetHelp( this, "help use carried", "Help!", "Hello i am being used","ah i love being carried", 20);
}

void GetButtonsFor( CBlob@ this, CBlob@ caller )
{
	CBitStream params;
	params.write_u16(caller.getNetworkID());
	caller.CreateGenericButton( 22, Vec2f_zero, this, this.getCommandID("eat"), "Eat", params );
}

void onCommand( CBlob@ this, u8 cmd, CBitStream @params )
{
	if (cmd == this.getCommandID("eat"))
	{
		const u16 Player = params.read_u16();
		CBlob@ blob = getBlobByNetworkID(Player);
		bool isServer = getNet().isServer();

		if (blob.get_s8("hunger") < 19)
		{
			this.server_Die(); // nom

			this.getSprite().PlaySound("/Eat.ogg");
			Sound::Play("Heart.ogg", blob.getPosition());
			
			blob.add_s8("hunger", 10);
			if (isServer)
			{
				blob.server_Heal(0.5f); //heal 1 heart; 1.0f, a hearty meal ;)
			}
		}
		else
		{
			//Bloated, "im so.. full."
			this.getSprite().PlaySound("/Entities/Characters/Sounds/NoAmmo.ogg");
		}
	}
}