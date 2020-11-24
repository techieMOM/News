# News

Notes :

# Architecture
 I have followed MVVM Architecture here and wrote few test cases
 
# Deployment Target
  App supports iOS 13 and above
  
# Network Layer
In DataManager.swift Making API Calls and Created CustomImageView.swift for image network call

I have made API calls with URLSession normal call with querystring i have done.Didn't write any network layers as single API call is there.

# Design Changes
 In First Screen Label is not aligned with image in Design i aligned it in my app.
 Details Screen designed but Description was limited from the API and tags were not coming so i have used dummy text of Title.
 NavigationViewController i have used to match the design we can customise the header of Details Controller as we required.
 When image is not there i'm just showing blue background color instead of placeholder.
 
 # Resources 
 AppConstants.swift - To main Constants structure of the app
 Custom Font used as per design 
 Extension for converting HTML text readable format
 BaseViewController Used as super class to make reusable base functions.
 News - Model using Decodable as we don't require Encodable here
