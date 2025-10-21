public class Main {
    public static void main(String[] args){
        System.out.println("=== TEST EVENTS ===");
        EventModel eventModel = new EventModel();
        eventModel.getAll();
        
        System.out.println("\n=== TEST CLIENTS ===");
        ClientModel clientModel = new ClientModel();
        clientModel.getAll();
        
        System.out.println("\n=== TEST ORDERS ===");
        OrderModel orderModel = new OrderModel();
        orderModel.getAll();
        
        System.out.println("\n=== TEST PAYMENTS ===");
        PaymentModel paymentModel = new PaymentModel();
        paymentModel.getAll();
        
        System.out.println("\n=== TEST TICKETS ===");
        TicketModel ticketModel = new TicketModel();
        ticketModel.getAll();
        
        // Test récupération par ID
        System.out.println("\n=== TEST GET BY ID ===");
        eventModel.getId(1);
        clientModel.getId(1);
        orderModel.getId(1);
        paymentModel.getId(1);
        ticketModel.getId(1);
        
        // Test insertion (décommentez pour tester)
        /*
        System.out.println("\n=== TEST INSERTION ===");
        String[] newClient = {"John", "Doe", "john.doe@example.com", "+123456789", "Paris"};
        clientModel.insertNewRow(newClient);
        */
    }
}