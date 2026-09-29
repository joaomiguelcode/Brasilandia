-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORDS
-----------------------------------------------------------------------------------------------------------------------------------------
Discords = {
	["Connect"] = "https://discord.com/api/webhooks/1155793917023899718/dRRPVZrw6CAv7kzEQK_mfPC2MgIJLOntdtKXDDgcvcD8oHXavTR5koLD_MOSruA8sbLd",
	["Disconnect"] = "https://discord.com/api/webhooks/1155794241595920445/ofTsZ4dNlzVeVZTMXS9loy_fCVMOgQt7sjPaNfCyGZ1QKIvAX4YjSCExZsA0U1qqExzX",
	["Airport"] = "https://discord.com/api/webhooks/1155794574816591932/Vaxl3l0tGi0rKo7a4IROSc0AtNWBitlGuB912kDf2a1m_ZDN3qjg_sLksdFePAqWuVoI",
	["Deaths"] = "https://discord.com/api/webhooks/1155794673793773610/EZVvc5-KAzfhkvkkjP6CeyWHECLH2Br_daUJn7Uo9HiBk4KK3vcbuBB3zhMIoKKU9zgk",
	["Police"] = "https://discord.com/api/webhooks/1155794804668633130/6jm-_5eIyUI7v4IyKrlemd_Y-qKA4EG3tGF0fhB2vAN1dkG9oKKk3sM0HpI3Ehwly_4q",
	["Paramedic"] = "https://discord.com/api/webhooks/1155794902358175764/IknJivEBn1BbbCX8vKqQK3OWDBALqn0IhD_lTKmbDcAW2IHehyCMMUDHnimVAozPxEOn",
	["Gemstone"] = "https://discord.com/api/webhooks/1165317513018605680/Ei_nf7YnBjfbjn1J8r3aQ8NyCTKvnesPk1Wt-yQttRi18SPS4KMwDfNwtVudAiJ_mlK4",
	["Login"] = "https://discord.com/api/webhooks/1157411977988145342/usHHBR9ikA6H1ct8K-i6R8Gk4a1K4_UsTYvxLdh1pZedj1aKudPDyAYiQvbp0DbuhuVq",
	["bau-casa-colocou"] = "https://discord.com/api/webhooks/1158809104496722063/_ZKze6inaSJoxyiLIGfjMEI2Y4QCtst2H_5gENsFq7Ih0L0Bqnuc1kysmw51IaA-HTAP",
	["bau-casa-tirou"] = "https://discord.com/api/webhooks/1158809361565634589/Fg6K6Bxa7SkqyfKsZRJA_hy4Ilc039khMN_K9In2QaGHhESFrcVqu9PfldeXWnTuvIH9",
	["bvida"] = "https://discord.com/api/webhooks/1155795617377947668/WsxcX9tmomcvn_8C41__kFye6jJlOJHn-zjHMsX-p9gRGsvFjM3o7FfykUmVZM9sqo6g",

	["wl"] = "https://discord.com/api/webhooks/1159483912154787920/Vsn_ZnIblzIz-ydMEkMvBgrqdHecs_Y95HUkdPvlkT2wBLm7GD-gxeCbX3d8QhLjLqA3",
	["unwl"] = "https://discord.com/api/webhooks/1159483985043394621/8-ba78B-hMWw2yZNrN5H-zLJzfiPz2Um1c_KMG9N5k4vHmtuZnIXPjSj-D3Nu15ei0ei",
	["remcar"] = "https://discord.com/api/webhooks/1159484142858289232/9jOrMlHfDtCu48wYvh0QxEDkX4bwqL0-b2p2PI34-fOWWECVHuroYVEzoxNemK0vP2Os",


	["group"] = "https://discord.com/api/webhooks/1158812983615565844/7wF04cbdwI5TLYBu8Mucc_KHRF2EWphOSSd2nlP-TI3vhlwmr3ggw8UfuL7xnB9IdWc7",
	["ungroup"] = "https://discord.com/api/webhooks/1158813078733992028/IfCQ5lk4dXxZPPb4cXTffqt_YwLv7vjebz9X9mIRy6knJ92WFPjje2CpqtBJrChatn3q",
	["dv"] = "https://discord.com/api/webhooks/1158840058879688795/semAdBFgtRw6GkLMcQz_d0XGWSAXrj1Xltk-qq1QpXlgIGTMcaQwvasG6sFYEe_-bylM"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORD
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Discord",function(Hook,Message,Color)
	PerformHttpRequest(Discords[Hook],function(err,text,headers) end,"POST",json.encode({
		username = ServerName,
		embeds = { { color = Color, description = Message } }
	}),{ ["Content-Type"] = "application/json" })
end)

