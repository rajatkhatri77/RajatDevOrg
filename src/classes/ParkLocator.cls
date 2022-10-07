public class ParkLocator {
    public static List<String> country(String country){
        ParkService.ParksImplPort ParkServices = 
            new ParkService.ParksImplPort();
        return ParkServices.byCountry(country);
    }
}