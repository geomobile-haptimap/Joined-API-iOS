rm -r ./Documentation/appledoc/
appledoc --exclude ./Joined-API-iOS/External/ --project-name Joined-API-iOS --project-company "GeoMobile GmbH" --company-id de.geomobile --output ./Documentation/appledoc/ --ignore ./Joined-API-iOS/External/ --ignore .m --keep-intermediate-files --keep-undocumented-objects --templates ./Documentation/appledoc-templates .
exit 0
