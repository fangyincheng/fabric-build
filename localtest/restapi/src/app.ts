

import * as http from 'http';
import * as express from 'express';
import * as bodyParser from 'body-parser';
import cors = require('cors');
import log4js = require('log4js');
const logger = log4js.getLogger('SampleWebApp');
import { RequestEx } from './interfaces';
import { getErrorMessage } from './utils';
import * as chaincode from './chaincode';
import * as ea from './enrollAdmin';

const SERVER_HOST = process.env.HOST || '127.0.0.1';
const SERVER_PORT = process.env.PORT || '4000';

// create express App
const app = express();

app.options('*', cors());
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
    extended: false
}));

async function invokeChainCode(req: RequestEx, res: express.Response) {
    logger.debug('==================== INVOKE ON CHAINCODE ==================');
    const peers = req.body.peers;
    const chaincodeName = req.params.chaincodeName;
    const channelName = req.params.channelName;
    const fcn = req.body.fcn;
    const args = req.body.args;
    logger.debug('channelName  : ' + channelName);
    logger.debug('chaincodeName : ' + chaincodeName);
    logger.debug('fcn  : ' + fcn);
    logger.debug('args  : ' + args);
    if (!chaincodeName) {
        res.json(getErrorMessage('\'chaincodeName\''));
        return;
    }
    if (!channelName) {
        res.json(getErrorMessage('\'channelName\''));
        return;
    }
    if (!fcn) {
        res.json(getErrorMessage('\'fcn\''));
        return;
    }
    if (!args) {
        res.json(getErrorMessage('\'args\''));
        return;
    }

    if (req.username != 'admin') {
        req.username = 'appUser';
    }
    const message = await chaincode.invoke(
        peers, channelName, chaincodeName, fcn, args, req.username, req.username);

    res.send(message);
}

const API_ENDPOINT_CHANNEL_INVOKE_CHAINCODE = '/channels/:channelName/chaincodes/:chaincodeName';

app.post(API_ENDPOINT_CHANNEL_INVOKE_CHAINCODE, invokeChainCode);

const server = http.createServer(app);
server.listen(SERVER_PORT);

ea.main();