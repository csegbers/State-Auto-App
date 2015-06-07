
-------------------------------------------------------
-- Store variables used across the entire app 
-------------------------------------------------------
local mappings = { 

      objects = {
                  Agency = {    -- name must match actual aobject name in parse
                          backtext = "<",
                          navigation = { 
                                          composer = {
                                               id = "x",     -- will be dynamically set
                                               lua="locatedetails",
                                               time=250, 
                                               effect="slideLeft",
                                               effectback="slideRight",
                                            },
                                      },
                          desc=   {
                                       plural="Agents",
                                       singular="Agency",
                                  } ,                           
                          functionname = {
                                        locate = "getagenciesnearby",
                                        details = "getagency",
                                         },
                          mapping = {
                                        id = "agencyCode",
                                        name = "agencyName", 
                                        miles = "milesTo", 
                                        geo="agencyGeo",
                                        street="agencyAddress",
                                        city="agencyCity",
                                        state="agencyState",
                                        zip="agencyZip",
                                        logo="agencyLogo",
                                     },
                            },
                   BodyShop = {    -- name must match actual aobject name in parse
                          backtext = "<",
                          navigation = { 
                                          composer = {
                                               id = "x",     -- will be dynamically set
                                               lua="locatedetails",
                                               time=250, 
                                               effect="slideLeft",
                                               effectback="slideRight",
                                            },
                                      },
                          desc=   {
                                       plural="Certified Repair Shops",
                                       singular="Certified Repair Shop",
                                  } ,    
                          functionname = {
                                        locate = "getbodyshopsnearby",
                                        details = "getbodyshop",
                                         },
                          mapping = {
                                        id = "BodyShopId",
                                        name = "CompanyName", 
                                        miles = "milesTo", 
                                        geo="ShopGeo",
                                        street="LineAddress1",
                                        city="City",
                                        state="State",
                                        zip="Zip",   
                                        logo="BodyShopLogo",
                                     },
                            },
 
               },   --objects
        }
      
return mappings