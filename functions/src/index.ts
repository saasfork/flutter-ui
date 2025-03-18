import { info, error } from "firebase-functions/logger";
import { onCall, HttpsError } from "firebase-functions/https";
import * as admin from "firebase-admin";

// Initialiser l'application Firebase Admin si ce n'est pas déjà fait
admin.initializeApp();

// Cloud Functions (Node.js)
exports.initializeUserClaims = onCall(async (request) => {
    info("Démarrage de l'initialisation des claims utilisateur", { uid: request.data?.uid });

    const { uid, claims } = request.data || {};

    if (!request.auth || request.auth.uid !== uid) {
        info("Tentative d'accès non autorisée", {
            requestAuthUid: request.auth?.uid,
            targetUid: uid
        });
        throw new HttpsError('permission-denied', 'Unauthorized');
    }

    info("Vérification d'authentification réussie", { uid });

    const userClaims = {
        ...claims,
        createdAt: Date.now(),
    };

    info("Définition des claims utilisateur", { uid, claims: userClaims });

    try {
        await admin.auth().setCustomUserClaims(uid, userClaims);
        info("Claims utilisateur définis avec succès", { uid });
    } catch (e) {
        error("Erreur lors de la définition des claims utilisateur", { uid, e });
        throw new HttpsError('internal', 'Erreur lors de la définition des claims', e);
    }

    info("Initialisation des claims utilisateur terminée avec succès", { uid });
    return { success: true };
});
