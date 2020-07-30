/*
 * Copyright Elasticsearch B.V. and/or licensed to Elasticsearch B.V. under one
 * or more contributor license agreements. Licensed under the Elastic License;
 * you may not use this file except in compliance with the Elastic License.
 */

package org.elasticsearch.xpack.idp.action;

import org.elasticsearch.Version;
import org.elasticsearch.action.support.WriteRequest;
import org.elasticsearch.common.io.stream.NamedWriteableRegistry;
import org.elasticsearch.test.VersionUtils;
import org.elasticsearch.xpack.idp.saml.test.IdpSamlTestCase;
import org.hamcrest.MatcherAssert;

import java.io.IOException;
import java.util.Collections;

import static org.hamcrest.Matchers.equalTo;

public class DeleteSamlServiceProviderRequestTests extends IdpSamlTestCase {

    public void testSerialization() throws IOException {
        final DeleteSamlServiceProviderRequest request = new DeleteSamlServiceProviderRequest(randomAlphaOfLengthBetween(1, 100),
            randomFrom(WriteRequest.RefreshPolicy.values()));
        final Version version = VersionUtils.randomVersionBetween(random(), Version.V_7_7_0, Version.CURRENT);
        final DeleteSamlServiceProviderRequest read = copyWriteable(request, new NamedWriteableRegistry(Collections.emptyList()),
            DeleteSamlServiceProviderRequest::new, version);
        MatcherAssert.assertThat("Serialized request with version [" + version + "] does not match original object",
            read, equalTo(request));
    }

}
