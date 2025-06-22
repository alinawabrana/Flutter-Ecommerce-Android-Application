const {onCall, HttpsError} = require("firebase-functions/v2/https");
const {defineSecret} = require("firebase-functions/params");
const admin = require("firebase-admin");

// Define secret key for Stripe
const STRIPE_SECRET_KEY = defineSecret("STRIPE_SECRET_KEY");

// Initialize Firebase Admin SDK
admin.initializeApp();

// Define the Cloud Function
exports.createPaymentIntent = onCall(
    {secrets: [STRIPE_SECRET_KEY]},
    async (request) => {
      const {amount, currency} = request.data;

      // Validate input
      if (!amount || !currency) {
        throw new HttpsError(
            "invalid-argument",
            "Both amount and currency are required",
        );
      }

      const parsedAmount = parseInt(amount, 10);
      const parsedCurrency = String(currency).toLowerCase();

      if (isNaN(parsedAmount) || parsedAmount <= 0) {
        throw new HttpsError(
            "invalid-argument",
            "Amount must be a positive number",
        );
      }

      try {
        const secretKey = await STRIPE_SECRET_KEY.value();
        const stripe = require("stripe")(secretKey);

        const paymentIntent = await stripe.paymentIntents.create({
          amount: parsedAmount,
          currency: parsedCurrency,
          automatic_payment_methods: {enabled: true},
        });

        return {clientSecret: paymentIntent.client_secret};
      } catch (error) {
        console.error("Stripe error:", error);
        throw new HttpsError(
            "internal",
            error.message || "Failed to create payment intent",
        );
      }
    },
);
